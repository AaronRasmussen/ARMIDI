//
//  ARMIDIDeviceType.swift
//
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public protocol ARMIDIDeviceType: ARMIDIObjectType {
    
    func numberOfEntities() -> Int
    func entityAtIndex<T: ARMIDIEntityType>(_ index: Int) throws -> T
    func getEntities<T: ARMIDIEntityType>() throws -> [T]
}

public extension ARMIDIDeviceType {
    
    func numberOfEntities() -> Int {
        return numberOfEntitiesForDevice(self.midiRef)
    }
    
    func entityAtIndex<T: ARMIDIEntityType>(_ index: Int) throws -> T {
        return try T(midiRef: entityAtIndexForDevice(self.midiRef, index: index))
    }
    
    func getEntities<T: ARMIDIEntityType>() throws  -> [T] {
        return try (0..<self.numberOfEntities()).map { try self.entityAtIndex($0) }
    }
}
