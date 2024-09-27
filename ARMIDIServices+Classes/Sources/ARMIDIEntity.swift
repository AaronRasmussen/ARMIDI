//
//  ARMIDIEntity.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public class ARMIDIEntity: ARMIDIObject, ARMIDIEntityType {
    
    public var sources: [ARMIDISource]? = nil
    public var destinations: [ARMIDIDestination]? = nil
    
    public override init(midiRef: MIDIObjectRef, objectType: MIDIObjectType) throws {
        try super.init(midiRef: midiRef, objectType: objectType)
        self.sources = try ARMIDI.sourcesForEntity(self.midiRef).map {
            return try ARMIDISource(midiRef: $0, objectType: objectType == .source ? MIDIObjectType.source : .externalSource)
        }
        self.destinations = try ARMIDI.destinationsForEntity(self.midiRef).map {
            return try ARMIDIDestination(midiRef: $0, objectType: objectType == .destination ? MIDIObjectType.source : .externalDestination)
        }
    }
    
    public override func deviceID() throws -> Int32? {
        return try super.deviceID()
    }
}
