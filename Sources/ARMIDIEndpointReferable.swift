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
