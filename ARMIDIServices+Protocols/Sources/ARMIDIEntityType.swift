//
//  ARMIDIEntityType.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public protocol ARMIDIEntityType: ARMIDIObjectType {
    
    init(midiRef: MIDIObjectRef) throws
    
    func device<T: ARMIDIDeviceType>() throws -> T
    func numberOfSources() -> Int
    func source<T: ARMIDIEndpointType>(atIndex: Int) throws -> T
    func sources<T: ARMIDIEndpointType>() throws -> [T]
    func numberOfDestinations() -> Int
    func destination<T: ARMIDIEndpointType>(atIndex: Int) throws -> T
    func destinations<T: ARMIDIEndpointType>() throws -> [T]
}

public extension ARMIDIEntityType {
    
    func device<T: ARMIDIDeviceType>() throws -> T {
        return try T(midiRef: self.midiRef)
    }
    
    func numberOfSources() -> Int {
        return ARMIDI.numberOfSources(forEntity: self.midiRef)
    }
    
    func source<T: ARMIDIEndpointType>(atIndex i: Int) throws -> T {
        return try T(midiRef: ARMIDI.source(forEntity: self.midiRef, atIndex: i))
    }
    
    func sources<T: ARMIDIEndpointType>() throws -> [T] {
        return try (0..<self.numberOfSources()).map { try self.source(atIndex: $0) }
    }
    
    func numberOfDestinations() -> Int {
        return ARMIDI.numberOfDestinations(forEntity: self.midiRef)
    }
    
    func destination<T: ARMIDIEndpointType>(atIndex i: Int) throws -> T {
        return try T(midiRef: ARMIDI.destination(forEntity: self.midiRef, atIndex: i))
    }
    
    func destinations<T: ARMIDIEndpointType>() throws -> [T] {
        return try (0..<self.numberOfDestinations()).map { try self.destination(atIndex: $0) }
    }
}
