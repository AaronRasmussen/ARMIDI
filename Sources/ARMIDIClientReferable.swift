//
//  ARMIDIClientReferable.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/6/25.
//

import CoreMIDI
import ARMIDIError

public protocol ClientReferable: ObjectReferable {
    
    
}

public typealias ClientNotificationHandler = (MIDINotification) -> ()

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
