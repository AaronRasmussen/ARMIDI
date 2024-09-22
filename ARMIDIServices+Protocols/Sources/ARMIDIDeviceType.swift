//
//  ARMIDIDeviceType.swift
//
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public protocol ARMIDIDeviceType: ARMIDIObjectType {
    
    func numberOfEntities() -> Int
    func entityAtIndex(_ index: Int) -> MIDIEntityRef
    func entities() -> [MIDIEntityRef]
}

public extension ARMIDIDeviceType {
    
    func numberOfEntities() -> Int {
        return numberOfEntitiesForDevice(self.midiRef)
    }
    
    func entityAtIndex(_ index: Int) -> MIDIEntityRef {
        return entityAtIndexForDevice(self.midiRef, index: index)
    }
    
    func entities() -> [MIDIEntityRef] {
        return (0..<self.numberOfEntities()).map { self.entityAtIndex($0) }
    }
}
