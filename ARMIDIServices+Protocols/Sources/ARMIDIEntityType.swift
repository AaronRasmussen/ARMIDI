//
//  ARMIDIEntityType.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public protocol ARMIDIEntityType: ARMIDIObjectType {
    
    func device() throws -> MIDIDeviceRef
    func numberOfSources() -> Int
    func sourceAtIndex(_ index: Int) -> MIDIEndpointRef
    func sources() -> [MIDIEndpointRef]
    func numberOfDestinations() -> Int
    func destinationAtIndex(_ index: Int) -> MIDIEndpointRef
    func destinations() -> [MIDIEndpointRef]
}

public extension ARMIDIEntityType {
    
    func device() throws -> MIDIDeviceRef {
        return try deviceForEntity(self.midiRef)
    }
    
    func numberOfSources() -> Int {
        return numberOfSourcesForEntity(self.midiRef)
    }
    
    func sourceAtIndex(_ index: Int) -> MIDIEndpointRef {
        return sourceAtIndexForEntity(self.midiRef, index: index)
    }
    
    func sources() -> [MIDIEndpointRef] {
        return (0..<self.numberOfSources()).map { self.sourceAtIndex($0) }
    }
    
    func numberOfDestinations() -> Int {
        return numberOfDestinationsForEntity(self.midiRef)
    }
    
    func destinationAtIndex(_ index: Int) -> MIDIEndpointRef {
        return destinationAtIndexForEntity(self.midiRef, index: index)
    }
    
    func destinations() -> [MIDIEndpointRef] {
        return (0..<self.numberOfDestinations()).map { self.destinationAtIndex($0) }
    }
}
