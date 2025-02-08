//
//  ARMIDIClient.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/6/25.
//

import CoreMIDI
import ARMIDIError

/// A block for handling `MIDINotification` messages received by a  MIDI client.
///
/// This block gets wrapped inside a `MIDINotifyBlock`, enabling the block to handle the `MIDINotification` directly instead of the `UnsafePointer<MIDINotification>` that gets passed to `MIDINotifyBlock`.
public typealias ClientNotificationHandler = (MIDINotification) -> ()

/// Creates a MIDI client.
///
/// - Parameters:
///   - name: The name of the MIDI client.
///   - notificationHandler: A `ClientNotificationHandler` for handling `MIDINotification` messages received by the MIDI client.
/// - Throws: `MIDIError`
/// - Returns: A `ClientReferable` MIDI client.
public func createClient(name: String, notificationHandler: ClientNotificationHandler?) throws -> ClientReferable {
    
    func notifyBlock(_ handler: ClientNotificationHandler?) -> MIDINotifyBlock? {
        
        guard
            let handle = handler
        else {
            return nil
        }
        
        return { notificationPointer in
            
            let notification = notificationPointer.pointee
            handle(notification)
        }
    }
    
    var client: MIDIClientRef = 0
    let status = MIDIClientCreateWithBlock(name as CFString, &client, notifyBlock(notificationHandler))
    
    guard
        status == 0
    else {
        throw MIDIError(status)
    }
    
    return client
}

extension MIDIClientRef: ClientReferable {
    
    public func createInputPort(name: String, messageHandler: @escaping MIDIReadBlock) throws -> InputPortReferable {
        
        return try ARMIDI.createInputPort(name: name, client: self.midiRef, messageHandler: messageHandler)
    }
}
