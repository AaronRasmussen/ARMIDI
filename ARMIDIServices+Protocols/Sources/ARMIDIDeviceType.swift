//
//  ARMIDIDeviceType.swift
//
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public protocol ARMIDIDeviceType: ARMIDIObjectType {
    
    init(midiRef: MIDIObjectRef) throws
    
    func numberOfEntities() -> Int
    func entity<T: ARMIDIEntityType>(atIndex i: Int) throws -> T
    func entities<T: ARMIDIEntityType>() throws -> [T]
}

public extension ARMIDIDeviceType {
    
    func numberOfEntities() -> Int {
        return ARMIDI.numberOfEntities(forDevice: self.midiRef)
    }
    
    func entity<T: ARMIDIEntityType>(atIndex i: Int) throws -> T {
        return try T(midiRef: ARMIDI.entity(forDevice: self.midiRef, atIndex: i))
    }
    
    func entities<T: ARMIDIEntityType>() throws  -> [T] {
        return try (0..<self.numberOfEntities()).map {
            try self.entity(atIndex: $0)
        }
    }
}
