//
//  ARMIDIDX21+SysExParser.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 10/7/24.
//

public class ARMIDIDX21SysExParser: ARMIDIParserType {
    
    public var currentState: ARMIDIParserState? = nil
    
    weak var midiManager: DX21MIDIManager? = nil
    
    public init() { }
    
    public func process(midiMessage m: ARMIDIParserMessage) {
        
        switch m {
        case .systemExclusive(data: let d):
            
            do {
                let t: SysExType = try {
                    
                    switch d.count {
                        
                    case kDX21ParamChangeTxByteCount:
                        return .paramChange
                        
                    case kDX21SingleVoiceTxByteCount:
                        return .bulkSingleVoice
                        
                    case kDX21AllVoicesTxByteCount:
                        return .bulkAllVoices
                        
                    default:
                        throw SysExError.invalidByteCount
                    }
                }()
                
                let _ = validate(sysExType: t, sysExData: d)
                
            } catch {
                print(error)
                return
            }
        default:
            return
        }
    }
    
    func checkSum(data d: Data) -> UInt8 {
        let twosComplementSum = d.reduce(Int(0), { sum, dataByte in
            sum + Int(~dataByte) + 1 })
        return UInt8(twosComplementSum & 0x7F)
    }
    
    func validate(sysExType t: SysExType, sysExData d: Data) -> Bool {
        
        do {
            switch t {
                
            case .paramChange:
                guard d[0] == StatusByteSystemExclusive else { throw SysExError.invalidSysExStatusByte }
                guard d[1] == kYamahaSysExID else { throw SysExError.invalidManufacturerID }
                guard d[2] >> 4 == 1 else { throw SysExError.invalidSubstatusChNumber }
                guard d[3] == kDX21ParamGroupNumber else { throw SysExError.invalidParameterGroupNumber }
                guard d[4].isDataByte else { throw SysExError.unexpectedStatusByte }
                guard d[5].isDataByte else { throw SysExError.unexpectedStatusByte }
                guard d[6] == StatusByteSystemCommonEOX else { throw SysExError.invalidEOX }
                
                return true
                
            case .bulkSingleVoice:
                guard d[0] == StatusByteSystemExclusive else { throw SysExError.invalidSysExStatusByte }
                guard d[1] == kYamahaSysExID else { throw SysExError.invalidManufacturerID }
                guard d[2] >> 4 == 0 else { throw SysExError.invalidSubstatusChNumber }
                guard d[3] == kDX21SingleVoiceBulkFormat else { throw SysExError.invalidFormatNumber }
                guard UInt16(d[4]) << 8 + UInt16(d[5]) == kDX21SingleVoiceDataByteCount else { throw SysExError.invalidByteCount }
                guard d[99] == checkSum(data: d[6..<99]) else { throw SysExError.invalidCheckSum }
                guard d[100] == StatusByteSystemCommonEOX else { throw SysExError.invalidEOX }
                
                return true
                
            case .bulkAllVoices:
                
                guard d[0] == StatusByteSystemExclusive else { throw SysExError.invalidSysExStatusByte }
                guard d[1] == kYamahaSysExID else { throw SysExError.invalidManufacturerID }
                guard d[2] >> 4 == 0 else { throw SysExError.invalidSubstatusChNumber }
                guard d[3] == kDX21AllVoicesBulkFormat else { throw SysExError.invalidFormatNumber }
                guard UInt16(d[4]) << 8 + UInt16(d[5]) == kDX21AllVoicesDataByteCount else { throw SysExError.invalidByteCount }
                guard d[4102] == checkSum(data: d[6..<4102]) else { throw SysExError.invalidCheckSum }
                guard d[4103] == StatusByteSystemCommonEOX else { throw SysExError.invalidEOX }
                
                return true
            }
        } catch {
            print(error)
            return false
        }
    }
    
    enum SysExType {
        case paramChange
        case bulkSingleVoice
        case bulkAllVoices
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
}
