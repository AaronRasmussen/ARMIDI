//
//  ARMIDIEndpointReferable.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/4/25.
//

import CoreMIDI
import ARMIDIError

public protocol EndpointReferable: ObjectReferable {
    
    /// The MIDI endpoint's parent MIDI entity.
    ///
    /// - Throws: `MIDIError`
    ///
    /// - Returns: A `MIDIEntityRef` for this MIDI endpoint's parent MIDI entity.
    func entity() throws -> EntityReferable
}

extension EndpointReferable {
    
    public func entity() throws -> EntityReferable {
        
        var entity: MIDIEntityRef = 0
        let status = MIDIEndpointGetEntity(self.midiRef, &entity)
        
        guard
            status == 0
        else {
            throw MIDIError(status)
        }
        
        return entity
    }
}
