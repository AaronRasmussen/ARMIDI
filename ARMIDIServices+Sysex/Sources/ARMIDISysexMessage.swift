//
//  ARMIDISysexMessage.swift
//  
//
//  Created by Aaron Rasmussen on 10/19/24.
//

import CoreMIDI

public func sysexSendRequestCallback(request: UnsafeMutablePointer<MIDISysexSendRequest>) {
    let r = request.pointee
    let context = r.completionRefCon?.bindMemory(to: Optional<ARMIDISysexMessageHandler>.self, capacity: 1).pointee
    context?.handle(sysexMessage: r)
}

public class ARMIDISysexMessage<T: ARMIDISysexMessageHandler> {
    private var _data: [UInt8]
    private var _context: T?
    private var _message: MIDISysexSendRequest!
    
    public var data: [UInt8] {
        return self._data
    }
    
    public var context: ARMIDISysexMessageHandler? {
        return self._context
    }
    
    public var message: MIDISysexSendRequest {
        return self._message
    }
    
    public init(sysexData d: [UInt8], destination: ARMIDIDestination, context: T?) {
        self._data = d
        self._context = context
        self._message = withUnsafeMutablePointer(to: &self._context) { context in
            self._data.withUnsafeBufferPointer { data in
                MIDISysexSendRequest(destination: destination.midiRef, data: data.baseAddress!, bytesToSend: UInt32(_data.count), complete: false, reserved: (0, 0, 0), completionProc: sysexSendRequestCallback, completionRefCon: context)
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
