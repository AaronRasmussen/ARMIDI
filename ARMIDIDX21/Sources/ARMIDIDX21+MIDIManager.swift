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
    
    lazy var scarlettMIDIDevice: ARMIDIDevice = {
        let devs = try! ARMIDIDevice.devices()
        guard let dev = devs.first(where: {
            try! $0.manufacturer() == "Focusrite"
        }) else { fatalError()}
        
        return dev
    }()
    
    lazy var midiSource: ARMIDISource = try! (scarlettMIDIDevice.entityAtIndex(0) as ARMIDIEntity).sourceAtIndex(0)
    
    lazy var midiDestination: ARMIDIDestination = try! (scarlettMIDIDevice.entityAtIndex(0) as ARMIDIEntity).destinationAtIndex(0)
    
    lazy var virtualClient = try! ARMIDIClient.createClient(name: "DX21_MIDI_Manager_Client", block: nil)
    
    lazy var inputPort: ARMIDIPort = {
        let port: ARMIDIPort = try! virtualClient.createInputPort(name: "DX21_MIDI_Manager_InputPort", block: readBlock)
        let _ = withUnsafeMutablePointer(to: &self.parser) { ptr in
            try! port.connectToSource(midiSource, withContext: ptr)
        }
        return port
    }()
    
    public init() { }
    
    func createSysexSwitchMessageData(channel ch: UInt8, switch s: UInt8, isOn: Bool) -> [UInt8] {
        
        var data = Array<UInt8>(repeating: 0, count: 5)
        
        data[0] = kYamahaSysExID
        data[1] = 0x10 & (ch - 1)
        data[2] = 0x08
        data[3] = s
        data[4] = isOn ? 0x7f : 0x00
        
        return data
    }
    
    func createSysexParamChangeMessageData(channel ch: UInt8, param p: UInt8, value v: UInt8) -> [UInt8] {
        
        var data = Array<UInt8>(repeating: 0, count: 5)
        
        data[0] = kYamahaSysExID
        data[1] = 0x10 & (ch - 1)
        data[2] = kDX21ParamGroupNumber
        data[3] = p
        data[4] = v
        
        return data
    }
    
    func createSysexDumpRequestMessageData(channel ch: UInt8, allVoices all: Bool) -> [UInt8] {
        
        var data = Array<UInt8>(repeating: 0, count: 3)
        
        data[0] = kYamahaSysExID
        data[1] = 0x20 & (ch - 1)
        data[2] = all ? kDX21AllVoicesBulkFormat : kDX21SingleVoiceBulkFormat
        
        return data
    }
    
    class SysExMessage<T> {
        var data: [UInt8]
        var context: T?
        var sendRequest: MIDISysexSendRequest!
        
        init(data: [UInt8], destination: ARMIDIDestination, byteCount: Int, context: T?, callback: MIDICompletionProc) {
            self.data = data
            self.context = context
            
            self.sendRequest = withUnsafeMutablePointer(to: &self.context) { ptr in
                createSysExSendRequest(destination: destination.midiRef, data: &self.data, byteCount: data.count, context: ptr, callback: callback)
            }
        }
        
        func send() throws {
            try sendSysExRequest(&self.sendRequest)
        }
    }
}
