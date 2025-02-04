//
//  ARMIDIObject.swift
//  
//
//  Created by Aaron Rasmussen on 2/3/25.
//

import CoreMIDI
import ARMIDIError

/// Search for the MIDI object with the given `MIDIUniqueID`.
///
/// `findObject(withUniqueID:)` is a Swift-friendly wrapper for `CoreMIDI`'s `MIDIObjectFindByUniqueID(_:_:_:)` function.
///
/// - Parameter uniqueID: The `MIDIUniqueID` used to search for the MIDI object.
///
/// - Returns: A tuple containing the `MIDIObjectRef` and `MIDIObjectType` of the sought-after MIDI object.
///
/// - Throws: `MIDIError`.  If the MIDI object is not found `MIDIError.objectNotFound` will be thrown.
public func findObject(withUniqueID uniqueID: MIDIUniqueID) throws -> (object: MIDIObjectRef, type: MIDIObjectType) {
    
    var object: MIDIObjectRef = 0
    var type: MIDIObjectType = .other
    
    let status = MIDIObjectFindByUniqueID(uniqueID, &object, &type)
    
    guard
        status == 0
    else {
        throw MIDIError(status)
    }
    
    return (object, type)
}

extension MIDIObjectReferable {
    
    /// Retrieves the identified `String` property.
    ///
    /// - Parameter property: A constant defined by `CoreMIDI` for referring to MIDI object properties.
    ///
    /// - Throws: `MIDIError`
    ///
    /// - Returns: A `String` value, or `nil` if the property is not set for the object.
    public func getStringProperty(_ property: CFString) throws -> String? {
        
        var stringProperty: Unmanaged<CFString>? = nil
        
        let status = MIDIObjectGetStringProperty(self.midiRef, property, &stringProperty)
        
        guard
            status != kMIDIUnknownProperty
        else { return nil }
        
        guard
            status == 0
        else {
            throw MIDIError(status)
        }
        
        return stringProperty?.takeUnretainedValue() as String?
    }
}
