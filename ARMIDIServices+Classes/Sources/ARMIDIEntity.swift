//
//  ARMIDIEntity.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public class ARMIDIEntity: ARMIDIObject, ARMIDIEntityType {
    
    public weak var device: ARMIDIDevice? = nil
    public var sources: [ARMIDISource]? = nil
    public var destinations: [ARMIDIDestination]? = nil
    
    public required convenience init(midiRef: MIDIObjectRef) throws {
        try self.init(midiRef: midiRef, objectType: .entity)
        self.sources = try ARMIDI.sources(forEntity: self.midiRef).map { try ARMIDISource(midiRef: $0) }
        self.destinations = try ARMIDI.destinations(forEntity: self.midiRef).map { try ARMIDIDestination(midiRef: $0) }
    }
    
    override init(midiRef: MIDIObjectRef, objectType: MIDIObjectType) throws {
        try super.init(midiRef: midiRef, objectType: objectType)
        self.device = try self.device()
    }
}

public class ARMIDIExternalEntity: ARMIDIEntity {
    
    override init(midiRef: MIDIObjectRef, objectType: MIDIObjectType) throws {
        try super.init(midiRef: midiRef, objectType: objectType)
    }
    
    public required convenience init(midiRef: MIDIObjectRef) throws {
        try self.init(midiRef: midiRef, objectType: .externalEntity)
        self.sources = try ARMIDI.sources(forEntity: self.midiRef).map { try ARMIDIExternalSource(midiRef: $0) }
        self.destinations = try ARMIDI.destinations(forEntity: self.midiRef).map { try ARMIDIExternalDestination(midiRef: $0) }
    }
}
