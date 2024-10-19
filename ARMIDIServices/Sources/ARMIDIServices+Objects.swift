//
//  ARMIDIServices+Objects.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public func findObject(withUniqueID uID: MIDIUniqueID) throws -> (MIDIObjectRef, MIDIObjectType) {
    var midiRef: MIDIObjectRef = 0
    var objectType: MIDIObjectType = .other
    let status = MIDIObjectFindByUniqueID(uID, &midiRef, &objectType)
    guard status == 0 else { throw ARMIDIError(status) }
    return (midiRef, objectType)
}

public func getProperties(forObject o: MIDIObjectRef, deep: Bool) throws -> CFPropertyList? {
    var properties: Unmanaged<CFPropertyList>? = nil
    let status = MIDIObjectGetProperties(o, &properties, deep)
    guard status == 0 else { throw ARMIDIError(status) }
    return properties?.takeUnretainedValue()
}

public func remove(property p: CFString, fromObject o: MIDIObjectRef) throws {
    let status = MIDIObjectRemoveProperty(o, p)
    guard status == 0 else { throw ARMIDIError(status) }
}

public func getStringProperty(forObject o: MIDIObjectRef, property p: CFString) throws -> String? {
    var stringProperty: Unmanaged<CFString>? = nil
    let status = MIDIObjectGetStringProperty(o, p, &stringProperty)
    guard status != kMIDIUnknownProperty else { return nil }
    guard status == 0 else { throw ARMIDIError(status) }
    return stringProperty?.takeUnretainedValue() as String?
}

public func setStringProperty(forObject o: MIDIObjectRef, toValue v: String, property p: CFString) throws {
    let status = MIDIObjectSetStringProperty(o, p, v as CFString)
    guard status == 0 else { throw ARMIDIError(status) }
}

public func getIntegerProperty(forObject o: MIDIObjectRef, property p: CFString) throws -> Int32? {
    var integerProperty: Int32 = 0
    let status = MIDIObjectGetIntegerProperty(o, p, &integerProperty)
    guard status != kMIDIUnknownProperty else { return nil }
    guard status == 0 else { throw ARMIDIError(status) }
    return integerProperty
}

public func setIntegerProperty(forObject o: MIDIObjectRef, toValue v: Int32, property p: CFString) throws {
    let status = MIDIObjectSetIntegerProperty(o, p, v)
    guard status == 0 else { throw ARMIDIError(status) }
}

public func getBooleanProperty(forObject o: MIDIObjectRef, property p: CFString) throws -> Bool? {
    guard let integerValue = try getIntegerProperty(forObject: o, property: p) else { return nil }
    return integerValue != 0
}

public func setBooleanProperty(forObject o: MIDIObjectRef, toValue v: Bool, property p: CFString) throws {
    return try setIntegerProperty(forObject: o, toValue: v ? 1 : 0, property: p)
}

public func getDataProperty(forObject o: MIDIObjectRef, property p: CFString) throws -> Data? {
    var data: Unmanaged<CFData>? = nil
    let status = MIDIObjectGetDataProperty(o, p, &data)
    guard status != kMIDIUnknownProperty else { return nil }
    guard status == 0 else { throw ARMIDIError(status) }
    return data?.takeUnretainedValue() as Data?
}

public func setDataProperty(forObject o: MIDIObjectRef, toValue v: Data, property p: CFString) throws {
    let status = MIDIObjectSetDataProperty(o, p, v as CFData)
    guard status == 0 else { throw ARMIDIError(status) }
}

public func getDictionaryProperty(forObject o: MIDIObjectRef, property p: CFString) throws -> [CFString: Any]? {
    var dictionary: Unmanaged<CFDictionary>? = nil
    let status = MIDIObjectGetDictionaryProperty(o, p, &dictionary)
    guard status != kMIDIUnknownProperty else { return nil }
    guard status == 0 else { throw ARMIDIError(status) }
    return dictionary?.takeUnretainedValue() as? [CFString: Any]
}

public func setDictionaryProperty(forObject o: MIDIObjectRef, toValue v: [CFString: Any], property p: CFString) throws {
    let status = MIDIObjectSetDictionaryProperty(o, p, v as CFDictionary)
    guard status == 0 else { throw ARMIDIError(status) }
}
