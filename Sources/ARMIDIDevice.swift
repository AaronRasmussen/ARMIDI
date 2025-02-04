//
//  ARMIDIDevice.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/3/25.
//

import CoreMIDI
import ARMIDIError

extension MIDIDeviceReferable {
    
    public func numberOfEntities() -> Int {
        return Int(MIDIDeviceGetNumberOfEntities(self.midiRef))
    }
    
    public func entity(atIndex index: Int) -> MIDIEntityRef {
        return MIDIDeviceGetEntity(self.midiRef, index)
    }
    
    public func entities() -> [MIDIEntityRef] {
        return (0..<self.numberOfEntities()).map(self.entity)
    }
}
