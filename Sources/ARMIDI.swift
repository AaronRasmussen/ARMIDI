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
    return Int(MIDIGetNumberOfDevices())
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
