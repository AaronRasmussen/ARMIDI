//
//  ARMIDIEndpointType.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI
public protocol ARMIDIEndpointType: ARMIDIObjectType {
    
    func entity<T: ARMIDIEntityType>() throws -> T
    func flushOutput() throws
}

public extension ARMIDIEndpointType {
    
    func entity<T: ARMIDIEntityType>() throws -> T {
        return try T(midiRef: (entityForEndpoint(self.midiRef)))
    }
    
    func flushOutput() throws {
        return try flushOutputForEndpoint(self.midiRef)
    }
}
