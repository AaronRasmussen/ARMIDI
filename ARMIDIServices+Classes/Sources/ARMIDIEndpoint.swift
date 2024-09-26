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
    
    public static func sources<T: ARMIDIEndpointType>() throws -> [T] {
        return try ARMIDI.sources().map { try T(midiRef: $0) }
    }
}

public class ARMIDIInternalSource: ARMIDISource {
    
    public required init(midiRef: MIDIEndpointRef) throws {
        try super.init(midiRef: midiRef, objectType: .source)
    }
}

public class ARMIDIExternalSource: ARMIDISource {
    
    public required init(midiRef: MIDIEndpointRef) throws {
        try super.init(midiRef: midiRef, objectType: .externalSource)
    }
}

public class ARMIDIDestination: ARMIDIEndpoint {
    
    public static func destinations<T: ARMIDIEndpointType>() throws -> [T] {
        return try ARMIDI.destinations().map { try T(midiRef: $0) }
    }
}

public class ARMIDIInternalDestination: ARMIDIDestination {
    
    public required init(midiRef: MIDIEndpointRef) throws {
        try super.init(midiRef: midiRef, objectType: .destination)
    }
}

public class ARMIDIExternalDestination: ARMIDIDestination {
    
    public required init(midiRef: MIDIEndpointRef) throws {
        try super.init(midiRef: midiRef, objectType: .externalDestination)
    }
}

