//
//  ARMIDIServices+Entities.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public func device(forEntity e: MIDIEntityRef) throws -> MIDIDeviceRef {
    var device: MIDIDeviceRef = 0
    let status = MIDIEntityGetDevice(e, &device)
    guard status == 0 else { throw ARMIDIError(status) }
    return device
}

public func numberOfSources(forEntity e: MIDIEntityRef) -> Int {
    return MIDIEntityGetNumberOfSources(e)
}

public func source(forEntity e: MIDIEntityRef, atIndex i: Int) -> MIDIEndpointRef {
    return MIDIEntityGetSource(e, i)
}

public func sources(forEntity e: MIDIEntityRef) -> [MIDIEndpointRef] {
    return (0..<numberOfSources(forEntity: e)).map {
        return source(forEntity: e, atIndex: $0)
    }
}

public func numberOfDestinations(forEntity e: MIDIEntityRef) -> Int {
    return MIDIEntityGetNumberOfDestinations(e)
}

public func destination(forEntity e: MIDIEndpointRef, atIndex i: Int) -> MIDIEndpointRef {
    return MIDIEntityGetDestination(e, i)
}

public func destinations(forEntity e: MIDIEntityRef) -> [MIDIEndpointRef] {
    return (0..<numberOfDestinations(forEntity: e)).map {
        destination(forEntity: e, atIndex: $0)
    }
}
