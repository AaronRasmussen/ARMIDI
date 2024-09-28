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
    func removeProperty(_ property: CFString) throws
    func getStringProperty(_ property: CFString) throws -> String?
    func setStringProperty(_ property: CFString, toValue value: String) throws
    func getIntegerProperty(_ property: CFString) throws -> Int32?
    func setIntegerProperty(_ property: CFString, toValue value: Int32) throws
    func getBooleanProperty(_ property: CFString) throws -> Bool?
    func setBooleanProperty(_ property: CFString, toValue value: Bool) throws
    func getDataProperty(_ property: CFString) throws -> Data?
    func setDataProperty(_ property: CFString, toValue value: Data) throws
    func getDictionaryProperty(_ property: CFString) throws -> [CFString: Any]?
    func setDictionaryProperty(_ property: CFString, toValue value: [CFString: Any]) throws
}

public extension ARMIDIObjectType {
    
    func getProperties(deep: Bool) throws -> CFPropertyList? {
        return try getPropertiesForObject(self.midiRef, deep: deep)
    }
    
    func removeProperty(_ property: CFString) throws {
        return try removePropertyFromObject(self.midiRef, property: property)
    }
    
    func getStringProperty(_ property: CFString) throws -> String? {
        return try getStringPropertyForObject(self.midiRef, property: property)
    }
    
    func setStringProperty(_ property: CFString, toValue value: String) throws {
        return try setStringPropertyForObject(self.midiRef, property: property, toValue: value)
    }
    
    func getIntegerProperty(_ property: CFString) throws -> Int32? {
        return try getIntegerPropertyForObject(self.midiRef, property: property)
    }
    
    func setIntegerProperty(_ property: CFString, toValue value: Int32) throws {
        return try setIntegerPropertyForObject(self.midiRef, property: property, toValue: value)
    }
    
    func getBooleanProperty(_ property: CFString) throws -> Bool? {
        return try getBooleanPropertyForObject(self.midiRef, property: property)
    }
    
    func setBooleanProperty(_ property: CFString, toValue value: Bool) throws {
        return try setBooleanPropertyForObject(self.midiRef, property: property, toValue: value)
    }
    
    func getDataProperty(_ property: CFString) throws -> Data? {
        return try getDataPropertyForObject(self.midiRef, property: property)
    }
    
    func setDataProperty(_ property: CFString, toValue value: Data) throws {
        return try setDataPropertyForObject(self.midiRef, property: property, toValue: value)
    }
    
    func getDictionaryProperty(_ property: CFString) throws -> [CFString: Any]? {
        return try getDictionaryPropertyForObject(self.midiRef, property: property)
    }
    
    func setDictionaryProperty(_ property: CFString, toValue value: [CFString: Any]) throws {
        return try setDictionaryPropertyForObject(self.midiRef, property: property, toValue: value)
    }
}

