//
//  ARMIDIEntityType.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public protocol ARMIDIEntityType: ARMIDIObjectType {
    
    func device<T: ARMIDIDeviceType>() throws -> T
    func numberOfSources() -> Int
    func sourceAtIndex<T: ARMIDIEndpointType>(_ index: Int) throws -> T
    func sources<T: ARMIDIEndpointType>() throws -> [T]
    func numberOfDestinations() -> Int
    func destinationAtIndex<T: ARMIDIEndpointType>(_ index: Int) throws -> T
    func destinations<T: ARMIDIEndpointType>() throws -> [T]
}

public extension ARMIDIEntityType {
    
    func device<T: ARMIDIDeviceType>() throws -> T {
        return try T(midiRef: self.midiRef)
    }
    
    func numberOfSources() -> Int {
        return numberOfSourcesForEntity(self.midiRef)
    }
    
    func sourceAtIndex<T: ARMIDIEndpointType>(_ index: Int) throws -> T {
        return try T(midiRef: sourceAtIndexForEntity(self.midiRef, index: index))
    }
    
    func sources<T: ARMIDIEndpointType>() throws -> [T] {
        return try (0..<self.numberOfSources()).map { try self.sourceAtIndex($0) }
    }
    
    func numberOfDestinations() -> Int {
        return numberOfDestinationsForEntity(self.midiRef)
    }
    
    func destinationAtIndex<T: ARMIDIEndpointType>(_ index: Int) throws -> T {
        return try T(midiRef: destinationAtIndexForEntity(self.midiRef, index: index))
    }
    
    func destinations<T: ARMIDIEndpointType>() throws -> [T] {
        return try (0..<self.numberOfDestinations()).map { try self.destinationAtIndex($0) }
    }
}
