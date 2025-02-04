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
}
