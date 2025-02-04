//
//  ARMIDIEndpoint.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/4/25.
//

import CoreMIDI
import ARMIDIError

extension MIDIEndpointRef: EndpointReferable {
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
