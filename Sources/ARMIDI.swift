//
//  ARMIDI.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/4/25.
//

import CoreMIDI
import ARMIDIError

/// Search for the MIDI object with the given `MIDIUniqueID`.
///
/// `findObject(withUniqueID:)` is a Swift-friendly wrapper for `CoreMIDI`'s `MIDIObjectFindByUniqueID(_:_:_:)` function.
///
/// - Parameter uniqueID: The `MIDIUniqueID` used to search for the MIDI object.
///
/// - Returns: A tuple containing the `MIDIObjectRef` and `MIDIObjectType` of the MIDI object.
///
/// - Throws: `MIDIError`.  If the MIDI object is not found `MIDIError.objectNotFound` will be thrown.
public func findObject(withUniqueID uniqueID: MIDIUniqueID) throws -> (object: ObjectReferable, type: MIDIObjectType) {
    
    var object: MIDIObjectRef = 0
    var type: MIDIObjectType = .other
    
    let status = MIDIObjectFindByUniqueID(uniqueID, &object, &type)
    
    guard
        status == 0
    else {
        throw MIDIError(status)
    }
    
    return (object, type)
}

/// The number of internal MIDI devices in the MIDI system.
///
/// - Returns: The number of internal MIDI devices in the MIDI system.
public func numberOfDevices() -> Int {
    return MIDIGetNumberOfDevices() as Int
}

/// The internal MIDI device in the MIDI system at the provided index.
///
/// - Parameter index: The index of the internal MIDI device to return.
///
/// - Returns: The `MIDIDeviceRef` of the internal MIDI device in the MIDI system at the provided index.
public func device(atIndex index: Int) -> DeviceReferable {
    return MIDIGetDevice(index)
}

/// An array of all internal MIDI devices in the system.
///
/// - Returns: An `Array<MIDIDeviceRef>` of all internal MIDI devices in the system.
public func devices() -> [DeviceReferable] {
    (0..<numberOfDevices()).map(device)
}

/// The number of MIDI sources in the MIDI system.
///
/// - Returns: The number of MIDI sources in the MIDI system.
public func numberOfSources() -> Int {
    return MIDIGetNumberOfSources() as Int
}

/// The number of MIDI destinations in the MIDI system.
///
/// - Returns: The number of MIDI destinations in the MIDI system.
public func numberOfDestinations() -> Int {
    return MIDIGetNumberOfDestinations() as Int
}

/// The MIDI source in the MIDI system at the provided index.
///
/// - Parameter index: The index of the MIDI source to return.
///
/// - Returns: The MIDI source in the MIDI system at the provided index.
public func source(atIndex index: Int) -> SourceReferable {
    return MIDIGetSource(index)
}

/// The MIDI destination in the MIDI system at the provided index.
///
/// - Parameter index: The index of the MIDI destination to return.
///
/// - Returns: The MIDI destination in the MIDI system at the provided index.
public func destination(atIndex index: Int) -> DestinationReferable {
    return MIDIGetDestination(index)
}

/// An array of all MIDI sources in the MIDI system.
///
/// - Returns: An array of all MIDI sources in the MIDI system.
public func sources() -> [SourceReferable] {
    return (0..<numberOfSources()).map(source)
}

/// An array of all MIDI destinations in the MIDI system.
///
/// - Returns: An array of all MIDI destinations in the MIDI system.
public func destinations() -> [DestinationReferable] {
    return (0..<numberOfDestinations()).map(destination)
}

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
