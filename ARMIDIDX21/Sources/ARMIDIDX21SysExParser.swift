//
//  ARMIDIDX21SysExParser.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 10/7/24.
//

public class ARMIDIDX21SysExParser: ARMIDIParser {
    
    enum SysExType {
        case parameter
        case bulkSingleVoice
        case bulkAllVoices
    }
    
    
    public override func process(midiMessage m: ARMIDIParserMessage?) {
        switch m {
        case .systemExclusive(data: let d):
            switch d.count {
            case 7:
                let _ = self.validate(sysExType: .parameter, sysExData: d)
            case 101:
                let _ = self.validate(sysExType: .bulkSingleVoice, sysExData: d)
            case 4104:
                let _ = self.validate(sysExType: .bulkAllVoices, sysExData: d)
            case let n:
                print("SysEx message has an invalid number of bytes (bytes received: \(n)).")
            }
        default:
            return
        }
    }
    
    enum SysExError: Error {
        case invalidSysExStatusByte
        case invalidManufacturerID
        case invalidSubstatusChNumber
        case invalidParameterGroupNumber
        case invalidFormatNumber
        case invalidByteCount
        case invalidCheckSum
        case unexpectedStatusByte
        case invalidEOX
    }
    
    func validate(sysExType t: SysExType, sysExData d: Data) -> Bool {
        
        do {
            
            switch t {
            case .parameter:
                guard d[0] == StatusByteSystemExclusive else { throw SysExError.invalidSysExStatusByte }
                guard d[1] == 0x43 else { throw SysExError.invalidManufacturerID }
                guard d[2] <= 0x1F else { throw SysExError.invalidSubstatusChNumber }
                guard d[3] == 0x12 else { throw SysExError.invalidParameterGroupNumber }
                guard d[4] <= 0x7F else { throw SysExError.unexpectedStatusByte }
                guard d[5] <= 0x7F else { throw SysExError.unexpectedStatusByte }
                guard d[6] == StatusByteSystemCommonEOX else { throw SysExError.invalidEOX }
                
                return true
                
            case .bulkSingleVoice:
                guard d[0] == StatusByteSystemExclusive else { throw SysExError.invalidSysExStatusByte }
                guard d[1] == 0x43 else { throw SysExError.invalidManufacturerID }
                guard d[2] <= 0x0F else { throw SysExError.invalidSubstatusChNumber }
                guard d[3] == 0x03 else { throw SysExError.invalidFormatNumber }
                guard UInt16(d[4]) << 8 + UInt16(d[5]) == 0x005D else { throw SysExError.invalidByteCount }
                
                let twosComplementSum: UInt = d[6..<99].reduce(UInt(0), { sum, dataByte in
                    sum + UInt(~dataByte) + 1 })
                let checkSum = UInt8(twosComplementSum & 0x7F)
                
                guard d[99] == checkSum else { throw SysExError.invalidCheckSum }
                
                guard d[100] == StatusByteSystemCommonEOX else { throw SysExError.invalidEOX }
                
                print("SysEx validates...")
                
                return true
                
            case .bulkAllVoices:
                
                guard d[0] == StatusByteSystemExclusive else { throw SysExError.invalidSysExStatusByte }
                guard d[1] == 0x43 else { throw SysExError.invalidManufacturerID }
                guard d[2] <= 0x0F else { throw SysExError.invalidSubstatusChNumber }
                guard d[3] == 0x04 else { throw SysExError.invalidFormatNumber }
                guard UInt16(d[4]) << 8 + UInt16(d[5]) == 0x2000 else { throw SysExError.invalidByteCount }
                
                let twosComplementSum: UInt = d[6..<4102].reduce(UInt(0), { sum, dataByte in
                    sum + UInt(~dataByte) + 1 })
                let checkSum = UInt8(twosComplementSum & 0x7F)
                
                guard d[4102] == checkSum else { throw SysExError.invalidCheckSum }
                guard d[4103] == StatusByteSystemCommonEOX else { throw SysExError.invalidEOX }
                
                return true
            }
        } catch {
            print(error)
        }
        return false
    }
}
