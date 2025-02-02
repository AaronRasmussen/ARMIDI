//
//  ARMIDIServices+Objects.swift
//  ARMIDI/ARMIDIServices/Sources/ARMIDIServices+Objects.swift
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

/// Search for the MIDI object with the given `MIDIUniqueID`.
///
/// `findObject(withUniqueID:)` is a Swift-friendly wrapper for `CoreMIDI`'s `MIDIObjectFindByUniqueID(_:_:_:)` function.
///
/// - Parameter uniqueID: The `MIDIUniqueID` used to search for the MIDI object.
///
/// - Returns: A tuple containing the `MIDIObjectRef` and `MIDIObjectType` of the sought-after MIDI object.
///
/// - Throws: `ARMIDIError`.  If the MIDI object is not found `ARMIDIError.objectNotFound` will be thrown.
public func findObject(withUniqueID uniqueID: MIDIUniqueID) throws -> (objectRef: MIDIObjectRef, objectType: MIDIObjectType) {
    
    var midiRef: MIDIObjectRef = 0
    var objectType: MIDIObjectType = .other
    
    let status = MIDIObjectFindByUniqueID(uniqueID, &midiRef, &objectType)
    
    guard
        status == 0
    else { throw ARMIDIError(status) }
    
    return (midiRef, objectType)
}

/// Returns all properties of an object.
///
/// `getProperties(forObject:deep:)` is a Swift-friendly wrapper for `CoreMIDI`'s `MIDIObjectGetProperties(_:_:_:)` function.
///
/// - Parameters:
///   - object: The object to query.
///   - deep: Specify `true` to include the object’s children; for example, a device’s entities, or an entity’s endpoints.
///
/// - Throws: `ARMIDIError`.
///
/// - Returns: An `Optional<CFPropertyList>` containing the object's properties.
public func getProperties(forObject object: MIDIObjectRef, deep: Bool) throws -> CFPropertyList? {
    
    var properties: Unmanaged<CFPropertyList>? = nil
    
    let status = MIDIObjectGetProperties(object, &properties, deep)
    
    guard
        status == 0
    else { throw ARMIDIError(status) }
    
    return properties?.takeUnretainedValue()
}

/// Removes an object’s property.
///
/// `remove(property:forObject:)` is a Swift-friendly wrapper for `CoreMIDI`'s `MIDIObjectRemoveProperty(_:_:)` function.
///
/// - Parameters:
///   - property: The property to remove.
///   - object: The object to modify.
///
/// - Throws: `ARMIDIError`
public func remove(property: CFString, forObject object: MIDIObjectRef) throws {
    
    let status = MIDIObjectRemoveProperty(object, property)
    
    guard
        status == 0
    else { throw ARMIDIError(status) }
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
