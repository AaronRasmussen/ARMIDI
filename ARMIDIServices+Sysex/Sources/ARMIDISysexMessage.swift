//
//  ARMIDISysexMessage.swift
//  
//
//  Created by Aaron Rasmussen on 10/19/24.
//

import CoreMIDI

public func sysexSendRequestCallback(request: UnsafeMutablePointer<MIDISysexSendRequest>) {
    let r = request.pointee
    let handler = r.completionRefCon?.bindMemory(to: ARMIDISysexMessageHandler.self, capacity: 1).pointee
    handler?.handle(sysexMessage: r)
}

public class ARMIDISysexMessage {
    private var _data: [UInt8]
    weak private var _handler: ARMIDISysexMessageHandler?
    private var _message: MIDISysexSendRequest!
    
    public var data: [UInt8] {
        return self._data
    }
    
    public var handler: ARMIDISysexMessageHandler? {
        return self._handler
    }
    
    public var message: MIDISysexSendRequest {
        return self._message
    }
    
    public init(sysexData d: [UInt8], destination: ARMIDIDestination, handler: ARMIDISysexMessageHandler?, callback: @escaping MIDICompletionProc) {
        self._data = d
        self._handler = handler
        self._message = withUnsafeMutablePointer(to: &self._handler) { context in
            self._data.withUnsafeBufferPointer { data in
                guard let baseAddress = data.baseAddress else { return nil }
                return MIDISysexSendRequest(destination: destination.midiRef, data: baseAddress, bytesToSend: UInt32(_data.count), complete: false, reserved: (0, 0, 0), completionProc: callback, completionRefCon: context)
            }
        }
    }
    
    public func send() throws -> Self {
        let status = withUnsafeMutablePointer(to: &self._message) { request in
            MIDISendSysex(request)
        }
        guard status == 0 else { throw ARMIDIError(status) }
        return self
    }
}
