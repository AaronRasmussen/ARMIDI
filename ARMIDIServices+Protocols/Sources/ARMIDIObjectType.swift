//
//  ARMIDIObjectType.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public protocol ARMIDIObjectType {
    
    var midiRef: UInt32 { get }
    
    func getProperties(deep: Bool) throws -> CFPropertyList?
    func remove(property: CFString) throws
    func getStringProperty(_: CFString) throws -> String?
    func setStringProperty(toValue: String, property: CFString) throws
    func getIntegerProperty(_: CFString) throws -> Int32?
    func setIntegerProperty(toValue: Int32, property: CFString) throws
    func getBooleanProperty(_: CFString) throws -> Bool?
    func setBooleanProperty(toValue: Bool, property: CFString) throws
    func getDataProperty(_: CFString) throws -> Data?
    func setDataProperty(toValue: Data, property: CFString) throws
    func getDictionaryProperty(_: CFString) throws -> [CFString: Any]?
    func setDictionaryProperty(toValue: [CFString: Any], property: CFString) throws
}

public extension ARMIDIObjectType {
    
    func getProperties(deep: Bool) throws -> CFPropertyList? {
        return try ARMIDI.getProperties(forObject: self.midiRef, deep: deep)
    }
    
    func remove(property p: CFString) throws {
        return try ARMIDI.remove(property: p, forObject: self.midiRef)
    }
    
    func getStringProperty(_ p: CFString) throws -> String? {
        return try ARMIDI.getStringProperty(forObject: self.midiRef, property: p)
    }
    
    func setStringProperty(toValue v: String, property p: CFString) throws {
        return try ARMIDI.setStringProperty(forObject: self.midiRef, toValue: v, property: p)
    }
    
    func getIntegerProperty(_ p: CFString) throws -> Int32? {
        return try ARMIDI.getIntegerProperty(forObject: self.midiRef, property: p)
    }
    
    func setIntegerProperty(toValue v: Int32, property p: CFString) throws {
        return try ARMIDI.setIntegerProperty(forObject: self.midiRef, toValue: v, property: p)
    }
    
    func getBooleanProperty(_ p: CFString) throws -> Bool? {
        return try ARMIDI.getBooleanProperty(forObject: self.midiRef, property: p)
    }
    
    func setBooleanProperty(toValue v: Bool, property p: CFString) throws {
        return try ARMIDI.setBooleanProperty(forObject: self.midiRef, toValue: v, property: p)
    }
    
    func getDataProperty(_ p: CFString) throws -> Data? {
        return try ARMIDI.getDataProperty(forObject: self.midiRef, property: p)
    }
    
    func setDataProperty(toValue v: Data, property p: CFString) throws {
        return try ARMIDI.setDataProperty(forObject: self.midiRef, toValue: v, property: p)
    }
    
    func getDictionaryProperty(_ p: CFString) throws -> [CFString: Any]? {
        return try ARMIDI.getDictionaryProperty(forObject: self.midiRef, property: p)
    }
    
    func setDictionaryProperty(toValue v: [CFString: Any], property p: CFString) throws {
        return try ARMIDI.setDictionaryProperty(forObject: self.midiRef, toValue: v, property: p)
    }
}

