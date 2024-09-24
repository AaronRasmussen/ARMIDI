//
//  ARMIDIObject.swift
//  
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public class ARMIDIObject: ARMIDIObjectType {
    
    public let midiRef: MIDIObjectRef
    public let uniqueID: MIDIUniqueID
    public let objectType: MIDIObjectType
    
    public init(midiRef: MIDIObjectRef, uniqueID: MIDIUniqueID, objectType: MIDIObjectType) {
        self.midiRef = midiRef
        self.uniqueID = uniqueID
        self.objectType = objectType
    }
    
    public convenience init?(midiRef: MIDIObjectRef) throws {
        guard let uniqueID = try getIntegerPropertyForObject(midiRef, property: kMIDIPropertyUniqueID) else {
            return nil
        }
        let (_, objectType) = try findObectWithUniqueID(uniqueID)
        self.init(midiRef: midiRef, uniqueID: uniqueID, objectType: objectType)
    }
    
    public func name() throws -> String? {
        return try self.getStringProperty(kMIDIPropertyName)
    }
    
    public func name(newValue value: String) throws {
        return try self.setStringProperty(kMIDIPropertyName, toValue: value)
    }
}
