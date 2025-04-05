//
//  ARMIDIObjectReferable.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/4/25.
//

import CoreMIDI
import ARMIDIError

/// A protocol for MIDI objects.
public protocol ObjectReferable {
    
    /// The `UInt32` value used to refer to the MIDI object.
    var midiRef: UInt32 { get }
    
    /// Retrieves the identified `String` property.
    ///
    /// - Parameter property: A constant defined by `CoreMIDI` for referring to MIDI object properties.
    ///
    /// - Throws: `MIDIError`
    ///
    /// - Returns: A `String` value, or `nil` if the property is not set for the object.
    func getStringProperty(_ property: CFString) throws -> String?
    
    /// Retrieves the identified `Int32` property.
    ///
    /// - Parameter property: A constant defined by `CoreMIDI` for referring to MIDI object properties.
    ///
    /// - Throws: `MIDIError`
    ///
    /// - Returns: An `Int32` value..
    func getIntegerProeprty(_ property: CFString) throws -> Int32
}

extension ObjectReferable {
    
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
    
    public func getIntegerProeprty(_ property: CFString) throws -> Int32 {
        
        var integer = Int32(0)
        let status = MIDIObjectGetIntegerProperty(self.midiRef, property, &integer)
        
        guard
            status == 0
        else{
            throw MIDIError(status)
        }
        
        return integer
    }
}

