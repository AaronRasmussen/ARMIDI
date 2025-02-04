//
//  ARMIDIEntity.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/4/25.
//

import CoreMIDI
import ARMIDIError

extension MIDIEntityRef: EntityReferable {
    
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
