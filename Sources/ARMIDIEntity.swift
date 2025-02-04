//
//  ARMIDIEntity.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/4/25.
//

import CoreMIDI
import ARMIDIError

extension MIDIEntityRef: EntityReferable {
    
    public func numberOfSources() -> Int {
        return MIDIEntityGetNumberOfSources(self.midiRef) as Int
    }
    
    public func numberOfDestinations() -> Int {
        return MIDIEntityGetNumberOfDestinations(self.midiRef) as Int
    }
    
    public func source(atIndex index: Int) -> MIDIEndpointRef {
        return MIDIEntityGetSource(self.midiRef, index)
    }
    
    public func destination(atIndex index: Int) -> MIDIEndpointRef {
        return MIDIEntityGetDestination(self.midiRef, index)
    }
    
    public func sources() -> [MIDIEndpointRef] {
        return (0..<self.numberOfSources()).map(self.source)
    }
    
    public func destinations() -> [MIDIEndpointRef] {
        return (0..<self.numberOfDestinations()).map(self.source)
    }
    
    
    public func device() throws -> MIDIDeviceRef {
        
        var device: MIDIDeviceRef = 0
        
        let status = MIDIEntityGetDevice(self.midiRef, &device)
        
        guard
            status == 0
        else {
            throw MIDIError(status)
        }
        
        return device
    }
}
