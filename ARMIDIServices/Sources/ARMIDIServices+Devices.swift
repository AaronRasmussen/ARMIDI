//
//  ARMIDIServices+Devices.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

/**
 Retiurms the number of internal devices connected to the CoreMIDI system.
 */
public func numberOfDevices() -> Int {
    return MIDIGetNumberOfDevices()
}

/**
 Returns the interal device at the given index.
 */
public func device(atIndex i: Int) -> MIDIDeviceRef {
    return MIDIGetDevice(i)
}

/**
 Returns an array containing references to all the internal devices connected to the CoreMIDI system.
 */
public func devices() -> [MIDIDeviceRef] {
    return (0..<numberOfDevices()).map {
        device(atIndex: $0)
    }
}

/**
 Retiurms the number of external devices connected to the CoreMIDI system.
 */
public func numberOfExternalDevices() -> Int {
    return MIDIGetNumberOfExternalDevices()
}

/**
 Returns the exteral device at the given index.
 */
public func externalDevice(atIndex i: Int) -> MIDIDeviceRef {
    return MIDIGetDevice(i)
}

/**
 Returns an array containing references to all the external devices connected to the CoreMIDI system.
 */
public func externalDevices() -> [MIDIDeviceRef] {
    return (0..<numberOfExternalDevices()).map {
        externalDevice(atIndex: $0)
    }
}

/**
 Retiurms the number of entities for the given device.
 */
public func numberOfEntities(forDevice d: MIDIDeviceRef) -> Int {
    return MIDIDeviceGetNumberOfEntities(d)
}

/**
 Returns the entity at the given index for the given device.
 */
public func entity(forDevice d: MIDIDeviceRef, atIndex i: Int) -> MIDIEntityRef {
    return MIDIDeviceGetEntity(d, i)
}

/**
 Returns an array containing references to all the entities for the given device..
 */
public func entities(forDevice d: MIDIDeviceRef) -> [MIDIEntityRef] {
    return (0..<numberOfEntities(forDevice: d)).map {
        return entity(forDevice: d, atIndex: $0)
    }
}
