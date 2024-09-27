//
//  ARMIDIEndpoint.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public class ARMIDIEndpoint: ARMIDIObject, ARMIDIEndpointType {
    
    public override func model() throws -> String? {
        return try super.model()
    }
    
    public override func manufacturer() throws -> String? {
        return try super.manufacturer()
    }
}

public class ARMIDISource: ARMIDIEndpoint {
    
    public override init(midiRef: MIDIObjectRef, objectType: MIDIObjectType) throws {
        try super.init(midiRef: midiRef, objectType: objectType)
    }
}

public class ARMIDIDestination: ARMIDIEndpoint {
    
    public override init(midiRef: MIDIObjectRef, objectType: MIDIObjectType) throws {
        try super.init(midiRef: midiRef, objectType: objectType)
    }
}
