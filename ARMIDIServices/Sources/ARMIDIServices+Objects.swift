//
//  ARMIDIServices+Objects.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public func findObectWith(uniqueID: MIDIUniqueID) throws -> (MIDIObjectRef, MIDIObjectType) {
    var midiRef: MIDIObjectRef = 0
    var objectType: MIDIObjectType = .other
    let status = MIDIObjectFindByUniqueID(uniqueID, &midiRef, &objectType)
    guard status == 0 else { throw ARMIDIError(status) }
    return (midiRef, objectType)
}

public func getPropertiesForObject(_ object: MIDIObjectRef, deep: Bool) throws -> CFPropertyList? {
    var properties: Unmanaged<CFPropertyList>? = nil
    let status = MIDIObjectGetProperties(object, &properties, deep)
    guard status == 0 else { throw ARMIDIError(status) }
    return properties?.takeUnretainedValue()
}

public func removePropertyFromObject(_ object: MIDIObjectRef, property: CFString) throws {
    let status = MIDIObjectRemoveProperty(object, property)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func getStringPropertyForObject(_ object: MIDIObjectRef, property: CFString) throws -> String? {
    var stringProperty: Unmanaged<CFString>? = nil
    let status = MIDIObjectGetStringProperty(object, property, &stringProperty)
    guard status != kMIDIUnknownProperty else { return nil }
    guard status == 0 else { throw ARMIDIError(status) }
    return stringProperty?.takeUnretainedValue() as String?
}

public func setStringPropertyForObject(_ object: MIDIObjectRef, property: CFString, toValue value: String) throws {
    let status = MIDIObjectSetStringProperty(object, property, value as CFString)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func getIntegerPropertyForObject(_ object: MIDIObjectRef, property: CFString) throws -> Int32? {
    var integerProperty: Int32 = 0
    let status = MIDIObjectGetIntegerProperty(object, property, &integerProperty)
    guard status != kMIDIUnknownProperty else { return nil }
    guard status == 0 else { throw ARMIDIError(status) }
    return integerProperty
}

public func setIntegerPropertyForObject(_ object: MIDIObjectRef, property: CFString, toValue value: Int32) throws {
    let status = MIDIObjectSetIntegerProperty(object, property, value)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func getBooleanPropertyForObject(_ object: MIDIObjectRef, property: CFString) throws -> Bool? {
    guard let integerValue = try getIntegerPropertyForObject(object, property: property) else { return nil }
    return integerValue != 0
}

public func setBooleanPropertyForObject(_ object: MIDIObjectRef, property: CFString, toValue value: Bool) throws {
    return try setIntegerPropertyForObject(object, property: property, toValue: value ? 1 : 0)
}

public func getDataPropertyForObject(_ object: MIDIObjectRef, property: CFString) throws -> Data? {
    var data: Unmanaged<CFData>? = nil
    let status = MIDIObjectGetDataProperty(object, property, &data)
    guard status != kMIDIUnknownProperty else { return nil }
    guard status == 0 else { throw ARMIDIError(status) }
    return data?.takeUnretainedValue() as Data?
}

public func setDataPropertyForObject(_ object: MIDIObjectRef, property: CFString, toValue value: Data) throws {
    let status = MIDIObjectSetDataProperty(object, property, value as CFData)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func getDictionaryPropertyForObject(_ object: MIDIObjectRef, property: CFString) throws -> [CFString: Any]? {
    var dictionary: Unmanaged<CFDictionary>? = nil
    let status = MIDIObjectGetDictionaryProperty(object, property, &dictionary)
    guard status != kMIDIUnknownProperty else { return nil }
    guard status == 0 else { throw ARMIDIError(status) }
    return dictionary?.takeUnretainedValue() as? [CFString: Any]
}

public func setDictionaryPropertyForObject(_ object: MIDIObjectRef, property: CFString, toValue value: [CFString: Any]) throws {
    let status = MIDIObjectSetDictionaryProperty(object, property, value as CFDictionary)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}
