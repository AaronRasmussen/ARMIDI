//
//  ARMIDIEntity.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/4/25.
//

import CoreMIDI
import ARMIDIError

extension MIDIEntityRef: EntityReferable {
    
    public func device() throws -> DeviceReferable {
        
        var device: MIDIDeviceRef = 0
        let status = MIDIEntityGetDevice(self.midiRef, &device)
        
        guard
            status == 0
        else {
            throw MIDIError(status)
        }
        
        return device
    }
    
    public func numberOfSources() -> Int {
        return MIDIEntityGetNumberOfSources(self.midiRef) as Int
    }
    
    public func numberOfDestinations() -> Int {
        return MIDIEntityGetNumberOfDestinations(self.midiRef) as Int
    }
    
    public func source(atIndex index: Int) -> EndpointReferable {
        return MIDIEntityGetSource(self.midiRef, index)
    }
    
    public func destination(atIndex index: Int) -> EndpointReferable {
        return MIDIEntityGetDestination(self.midiRef, index)
    }
    
    public func sources() -> [EndpointReferable] {
        return (0..<self.numberOfSources()).map(self.source)
    }
    
    public func destinations() -> [EndpointReferable] {
        return (0..<self.numberOfDestinations()).map(self.destination)
    }
}
