//
//  ARMIDIDX21+MIDIManager.swift
//  Pods
//
//  Created by Aaron Rasmussen on 10/14/24.
//

import CoreMIDI

public func createSysExSendRequest(destination: MIDIEndpointRef, data: UnsafePointer<UInt8>, byteCount: Int, context: UnsafeMutableRawPointer?, callback: MIDICompletionProc) -> MIDISysexSendRequest {
    
    let request = MIDISysexSendRequest(destination: destination, data: data, bytesToSend: UInt32(byteCount), complete: false, reserved: (0,0,0), completionProc: callback, completionRefCon: context)
    
    return request
}

public func sendSysExRequest(_ request: inout MIDISysexSendRequest) throws {
    let status = MIDISendSysex(&request)
    guard status == 0 else { throw ARMIDIError(status) }
}

func readBlock(packetList: UnsafePointer<MIDIPacketList>, context: UnsafeMutableRawPointer?) {
    return
}

public class DX21MIDIManager {
    
    var parser = ARMIDIDX21SysExParser()
    
    var midiSource: ARMIDISource? = nil
    var midiDestination: ARMIDIDestination? = nil
    var virtualClient: ARMIDIClient? = nil
    var inputPort: ARMIDIPort? = nil
    
    var messageId = 0
    
    var messages: [SysexMessage] = []
    
    enum SysexTransmissionType {
        case switchControl(channel: UInt8, switch: UInt8, isOn: Bool)
        case parameterChange(channel: UInt8, parameter: UInt8, value: UInt8)
        case singleVoiceDumpRequest(channel: UInt8)
        case allVoicesDumpRequest(channel: UInt8)
        case sendSingleVoice(channel: UInt8, voiceData: [UInt8])
        case sendAllVoices(channel: UInt8, voiceData: [UInt8])
    }
    
    public init?() {
        do {
            self.parser.midiManager = self
            let midiSources = try ARMIDI.sources().map( { (ref: UInt32) throws -> ARMIDISource? in
                try ARMIDISource(midiRef: ref) })
            
        } catch {
            print(error)
            return nil
        }
    }
    
    func createSysexData(type: SysexTransmissionType) -> [UInt8] {
        switch type {
            
        case .switchControl(let ch, let s, let isOn):
            var data = Array<UInt8>(repeating: 0, count: 5)
            data[0] = kYamahaSysExID
            data[1] = 0x10 & (ch - 1)
            data[2] = 0x08
            data[3] = s
            data[4] = isOn ? 0x7f : 0x00
            return data
            
        case .parameterChange(let ch, let p, let v):
            var data = Array<UInt8>(repeating: 0, count: 5)
            data[0] = kYamahaSysExID
            data[1] = 0x10 & (ch - 1)
            data[2] = kDX21ParamGroupNumber
            data[3] = p
            data[4] = v
            return data
            
        case .singleVoiceDumpRequest(let ch):
            var data = Array<UInt8>(repeating: 0, count: 3)
            data[0] = kYamahaSysExID
            data[1] = 0x20 & (ch - 1)
            data[2] = kDX21SingleVoiceBulkFormat
            return data
            
        case .allVoicesDumpRequest(let ch):
            var data = Array<UInt8>(repeating: 0, count: 3)
            data[0] = kYamahaSysExID
            data[1] = 0x20 & (ch - 1)
            data[2] = kDX21AllVoicesBulkFormat
            return data
            
        case .sendSingleVoice(let ch, let vD):
            var data = Array<UInt8>(repeating: 0, count: 99)
            data[0] = kYamahaSysExID
            data[1] = ch - 1
            data[2] = kDX21SingleVoiceBulkFormat
            data[3] = 0x00
            data[4] = 0x5D
            let _ = (0..<vD.count).map { data[$0 + 5] = vD[$0] }
            data[98] = parser.checkSum(data: Data(data[0..<98]))
            return data
            
        case .sendAllVoices(let ch, let vD):
            var data = Array<UInt8>(repeating: 0, count: 4102)
            data[0] = kYamahaSysExID
            data[1] = ch - 1
            data[2] = kDX21AllVoicesBulkFormat
            data[3] = 0x20
            data[4] = 0x00
            let _ = (0..<vD.count).map { data[$0 + 5] = vD[$0] }
            data[4101] = parser.checkSum(data: Data(data[0..<4101]))
            return data
        }
    }
    
    class SysexMessage {
        var dataBytes: [UInt8]
        var context: Any?
        var sendRequest: MIDISysexSendRequest!
        
        init(dataBytes bs: [UInt8], destination: ARMIDIDestination, byteCount: Int, context: Any?, callback: MIDICompletionProc) {
            self.dataBytes = bs
            self.context = context
            self.sendRequest = withUnsafeMutablePointer(to: &self.context) { ptr in
                createSysExSendRequest(destination: destination.midiRef, data: &self.dataBytes, byteCount: dataBytes.count, context: ptr, callback: callback)
            }
        }
        
        func send() throws -> SysexMessage {
            try sendSysExRequest(&self.sendRequest)
            return self
        }
    }
}
