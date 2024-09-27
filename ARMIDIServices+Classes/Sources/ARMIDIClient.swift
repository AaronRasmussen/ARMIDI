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
    
    public static func createClient(name: String, context: UnsafeMutableRawPointer?, callback: MIDINotifyProc?) throws -> ARMIDIClient {
        return ARMIDIClient(midiRef: try ARMIDI.createClient(name: name, context: context, callback: callback))
    }
    
    public static func createClient(name: String, block: MIDINotifyBlock?) throws -> ARMIDIClient {
        return ARMIDIClient(midiRef: try ARMIDI.createClient(name: name, block: block))
    }
    
    public func name() throws -> String? {
        return try getStringPropertyForObject(self.midiRef, property: kMIDIPropertyName)
    }
    
    public func setModelForSourceAtIndex(_ index: Int, newValue value: String) throws {
        try virtualSources?[index].model(newValue: value)
        return
    }
    
    public func setManufacturerForSourceAtIndex(_ index: Int, newValue value: String) throws {
        try virtualSources?[index].manufacturer(newValue: value)
        return
    }
    
    public func setUniqueIDForSourceAtIndex(_ index: Int, newValue value: Int32) throws {
        try virtualSources?[index].uniqueID(newValue: value)
        return
    }
    
    public func setModelForDestinationAtIndex(_ index: Int, newValue value: String) throws {
        try virtualDestinations?[index].model(newValue: value)
        return
    }
    
    public func setManufacturerForDestinationAtIndex(_ index: Int, newValue value: String) throws {
        try virtualDestinations?[index].manufacturer(newValue: value)
        return
    }
    
    public func setUniqueIDForDestinationAtIndex(_ index: Int, newValue value: Int32) throws {
        try virtualDestinations?[index].uniqueID(newValue: value)
        return
    }
}
