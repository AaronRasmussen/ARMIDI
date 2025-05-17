//
//  ARMIDISysexMessage.swift
//  ARMIDISysex
//
//  Created by Aaron Rasmussen on 2/25/25.
//

import CoreMIDI
import ARMIDIError
import Foundation

/// A system exclusive MIDI message.
///
/// `SysexMessage` is used to send a MIDI system exclusive message to a MIDI destination.
///
/// An empty `SysexMessage` is created using `SysexMessage()`. The data to send, the destination to send it to, and an optional completion handler are suppled wihen calling the `send(sysexData:to:completionhandler:)` instance method.
public class SysexMessage {
    
    fileprivate var data: [UInt8] = []
    fileprivate var handle: ((MIDISysexSendRequest) -> Void)? = nil
    fileprivate var sendRequest: MIDISysexSendRequest! = nil
    
    /// Initialize a `SysexMessage`.
    public init() { }
    
    /// Send a `SysexMessage` to a MIDI destination with an optional completion handler.
    ///
    /// - Parameters:
    ///   - sysexData: The data to send. The array should begin with the MIDI system exclusive status byte `0xF0` and end with the `EOX` status byte `0xF7`.
    ///   - destination: The MIDI destination that will receive the message.
    ///   - completionHandler: A completion handler that will be called when the transmission is complete.
    /// - Throws: `MIDIError`
    public func send(_ data: [UInt8], to destination: any DestinationReferable, completionHandler handler: ((MIDISysexSendRequest) -> Void)?) throws {
        
        let count = data.count

        self.data = data
        self.handle = handler
        self.sendRequest = self.data.withUnsafeBufferPointer() { ptr -> MIDISysexSendRequest in
            
            guard
                let baseAddress = ptr.baseAddress
            else {
                fatalError("Unable to obtain base address.")
            }
            
            return MIDISysexSendRequest(
                destination: destination.midiRef,
                data: baseAddress,
                bytesToSend: UInt32(count),
                complete: false,
                reserved: (0,0,0),
                completionProc: sendRequestCompletionWrapper,
                completionRefCon: Unmanaged.passRetained(self).toOpaque()
            )
            
        }
        
        let status = MIDISendSysex(&self.sendRequest)
        
        guard
            status == 0
        else {
            throw MIDIError(status)
        }
    }
}

fileprivate func sendRequestCompletionWrapper(_ sysexSendRequestPointer: UnsafeMutablePointer<MIDISysexSendRequest>) -> Void {

    let sysexSendRequest = sysexSendRequestPointer.pointee

    guard
        let unwrappedRawHandler = sysexSendRequest.completionRefCon
    else {
        return
    }

    let unmanagedHandler = Unmanaged<SysexMessage>.fromOpaque(unwrappedRawHandler)
    let handler = unmanagedHandler.takeRetainedValue()

    handler.handle?(sysexSendRequest)
    handler.sendRequest = nil
    handler.handle = nil
}
