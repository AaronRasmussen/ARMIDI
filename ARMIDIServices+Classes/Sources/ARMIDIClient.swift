//
//  ARMIDIClient.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public class ARMIDIClient: ARMIDIClientType {
    
    public let midiRef: MIDIClientRef
    
    var virtualSources: [ARMIDISource]? = nil
    var virtualDestinations: [ARMIDIDestination]? = nil
    
    internal init(midiRef: MIDIClientRef) {
        self.midiRef = midiRef
    }
    
    public static func createClient(name n: String, context c: UnsafeMutableRawPointer?, callback cb: MIDINotifyProc?) throws -> ARMIDIClient {
        return ARMIDIClient(midiRef: try ARMIDI.createClient(name: n, context: c, callback: cb))
    }
    
    public static func createClient(name n: String, block b: MIDINotifyBlock?) throws -> ARMIDIClient {
        return ARMIDIClient(midiRef: try ARMIDI.createClient(name: n, block: b))
    }
    
    public func name() throws -> String? {
        return try ARMIDI.getStringProperty(forObject: self.midiRef, property: kMIDIPropertyName)
    }
    
    public func setModel(forSourceAtIndex i: Int, toValue v: String) throws {
        try virtualSources?[i].model(newValue: v)
    }
    
    public func setManufacturer(forSourceAtIndex i: Int, toValue v: String) throws {
        try virtualSources?[i].manufacturer(newValue: v)
    }
    
    public func setUniqueID(forSourceAtIndex i: Int, toValue v: Int32) throws {
        try virtualSources?[i].uniqueID(newValue: v)
    }
    
    public func setModel(forDestinationAtIndex i: Int, newValue v: String) throws {
        try virtualDestinations?[i].model(newValue: v)
    }
    
    public func setManufacturer(forDestinationAtIndex i: Int, toValue v: String) throws {
        try virtualDestinations?[i].manufacturer(newValue: v)
    }
    
    public func setUniqueID(forDestinationAtIndex i: Int, newValue v: Int32) throws {
        try virtualDestinations?[i].uniqueID(newValue: v)
    }
}
