//
//  ARMIDIServices+Devices.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public func numberOfDevices() -> Int {
    return MIDIGetNumberOfDevices()
}

public func deviceAtIndex(_ index: Int) -> MIDIDeviceRef {
    return MIDIGetDevice(index)
}

public func devices() -> [MIDIDeviceRef] {
    return (0..<MIDIGetNumberOfDevices()).map { MIDIGetDevice($0) }
}

public func numberOfExternalDevices() -> Int {
    return MIDIGetNumberOfExternalDevices()
}

public func externalDeviceAtIndex(_ index: Int) -> MIDIDeviceRef {
    return MIDIGetDevice(index)
}

public func externalDevices() -> [MIDIDeviceRef] {
    return (0..<MIDIGetNumberOfExternalDevices()).map { MIDIGetExternalDevice($0) }
}

public func numberOfEntitiesForDevice(_ device: MIDIDeviceRef) -> Int {
    return MIDIDeviceGetNumberOfEntities(device)
}

public func entityAtIndexForDevice(_ device: MIDIDeviceRef, index: Int) -> MIDIEntityRef {
    return MIDIDeviceGetEntity(device, index)
}

public func entitiesForDevice(_ device: MIDIDeviceRef) -> [MIDIEntityRef] {
    return (0..<numberOfEntitiesForDevice(device)).map {
        return entityAtIndexForDevice(device, index: $0)
    }
}
