//
//  ARMIDIObject.swift
//  
//
//  Created by Aaron Rasmussen on 2/3/25.
//

import CoreMIDI
import ARMIDIError

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
