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

public class ARMIDISource: ARMIDIEndpoint { }

public class ARMIDIInternalSource: ARMIDISource {
    
    public init(midiRef: MIDIEndpointRef) throws {
        try super.init(midiRef: midiRef, objectType: .source)
    }
}

public class ARMIDIExternalSource: ARMIDISource {
    
    public init(midiRef: MIDIEndpointRef) throws {
        try super.init(midiRef: midiRef, objectType: .externalSource)
    }
}

public class ARMIDIDestination: ARMIDIEndpoint { }

public class ARMIDIInternalDestination: ARMIDIDestination {
    
    public init(midiRef: MIDIEndpointRef) throws {
        try super.init(midiRef: midiRef, objectType: .destination)
    }
}

public class ARMIDIExternalDestination: ARMIDIDestination {
    
    public init(midiRef: MIDIEndpointRef) throws {
        try super.init(midiRef: midiRef, objectType: .externalDestination)
    }
}

