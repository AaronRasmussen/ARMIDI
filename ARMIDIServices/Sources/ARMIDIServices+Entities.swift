//
//  ARMIDIServices+Entities.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public func deviceForEntity(_ entity: MIDIEntityRef) throws -> MIDIDeviceRef {
    var device: MIDIDeviceRef = 0
    let status = MIDIEntityGetDevice(entity, &device)
    guard status == 0 else { throw ARMIDIError(status) }
    return device
}

public func numberOfSourcesForEntity(_ entity: MIDIEntityRef) -> Int {
    return MIDIEntityGetNumberOfSources(entity)
}

public func sourceAtIndexForEntity(_ entity: MIDIEntityRef, index: Int) -> MIDIEndpointRef {
    return MIDIEntityGetSource(entity, index)
}

public func sourcesForEntity(_ entity: MIDIEntityRef) -> [MIDIEndpointRef] {
    return (0..<numberOfSourcesForEntity(entity)).map {
        return sourceAtIndexForEntity(entity, index: $0)
    }
}

public func numberOfDestinationsForEntity(_ entity: MIDIEntityRef) -> Int {
    return MIDIEntityGetNumberOfDestinations(entity)
}

public func destinationAtIndexForEntity(_ entity: MIDIEndpointRef, index: Int) -> MIDIEndpointRef {
    return MIDIEntityGetDestination(entity, index)
}

public func destinationsForEntity(_ entity: MIDIEntityRef) -> [MIDIEndpointRef] {
    return (0..<numberOfDestinationsForEntity(entity)).map {
        destinationAtIndexForEntity(entity, index: $0)
    }
}
