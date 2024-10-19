//
//  ARMIDIEntity.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public class ARMIDIEntity: ARMIDIObject, ARMIDIEntityType {
    
    public required convenience init(midiRef: MIDIObjectRef) throws {
        try self.init(midiRef: midiRef, objectType: .entity)
    }
    
    override init(midiRef: MIDIObjectRef, objectType: MIDIObjectType) throws {
        try super.init(midiRef: midiRef, objectType: objectType)
    }
    
    public func device() throws -> ARMIDIDevice {
        return try ARMIDIDevice(midiRef: ARMIDI.device(forEntity: self.midiRef))
    }
    
    func source(atIndex i: Int) throws -> ARMIDISource {
        return try ARMIDISource(midiRef: ARMIDI.source(forEntity: self.midiRef, atIndex: i))
    }
    
    func sources() throws -> [ARMIDISource] {
        return try (0..<self.numberOfSources()).map { try self.source(atIndex: $0) }
    }
    
    func destination(atIndex i: Int) throws -> ARMIDIDestination {
        return try ARMIDIDestination(midiRef: ARMIDI.destination(forEntity: self.midiRef, atIndex: i))
    }
    
    func destinations() throws -> [ARMIDIDestination] {
        return try (0..<self.numberOfDestinations()).map { try self.destination(atIndex: $0) }
    }
}

public class ARMIDIExternalEntity: ARMIDIEntity {
    
    override init(midiRef: MIDIObjectRef, objectType: MIDIObjectType) throws {
        try super.init(midiRef: midiRef, objectType: objectType)
    }
    
    public required convenience init(midiRef: MIDIObjectRef) throws {
        try self.init(midiRef: midiRef, objectType: .externalEntity)
    }
}
