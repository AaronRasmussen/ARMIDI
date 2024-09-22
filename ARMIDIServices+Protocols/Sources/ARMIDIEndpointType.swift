//
//  ARMIDIEndpointType.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI
public protocol ARMIDIEndpointType: ARMIDIObjectType {
    
    func entity() throws -> MIDIEntityRef
    func flushOutput() throws
}

public extension ARMIDIEndpointType {
    
    func entity() throws -> MIDIEntityRef {
        return try entityForEndpoint(self.midiRef)
    }
    
    func flushOutput() throws {
        return try flushOutputForEndpoint(self.midiRef)
    }
}
