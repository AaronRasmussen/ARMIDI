//
//  ARMIDIEndpoint.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public class ARMIDISource: ARMIDIObject, ARMIDIEndpointType {
    
    public required convenience init(midiRef: MIDIObjectRef) throws {
        try self.init(midiRef: midiRef, objectType: .source)
    }
    
    override init(midiRef: MIDIObjectRef, objectType: MIDIObjectType) throws {
        try super.init(midiRef: midiRef, objectType: objectType)
    }
}

public class ARMIDIExternalSource: ARMIDISource {
    
    public required init(midiRef: MIDIObjectRef) throws {
        try super.init(midiRef: midiRef, objectType: .externalSource)
    }
}

public class ARMIDIDestination: ARMIDIObject, ARMIDIEndpointType {
    
    public required convenience init(midiRef: MIDIObjectRef) throws {
        try self.init(midiRef: midiRef, objectType: .source)
    }
    
    override init(midiRef: MIDIObjectRef, objectType: MIDIObjectType) throws {
        try super.init(midiRef: midiRef, objectType: objectType)
    }
}

public class ARMIDIExternalDestination: ARMIDIDestination {
    
    public required init(midiRef: MIDIObjectRef) throws {
        try super.init(midiRef: midiRef, objectType: .externalDestination)
    }
}
