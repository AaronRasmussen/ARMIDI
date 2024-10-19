//
//  ARMIDIEndpointType.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI
public protocol ARMIDIEndpointType: ARMIDIObjectType {
    
    init(midiRef: MIDIObjectRef) throws
    
    func getEntity<T: ARMIDIEntityType>() throws -> T
    func flushOutput() throws
}

public extension ARMIDIEndpointType {
    
    func getEntity<T: ARMIDIEntityType>() throws -> T {
        return try T(midiRef: entity(forEndpoint: self.midiRef))
    }
    
    func flushOutput() throws {
        return try ARMIDI.flushOutput(forEndpoint: self.midiRef)
    }
}
