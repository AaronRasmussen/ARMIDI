//
//  ARMIDIEndpointReferable.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/4/25.
//

import CoreMIDI
import ARMIDIError

public protocol EndpointReferable: ObjectReferable {
    
    func entity() throws -> EntityReferable
}
