//
//  ARMIDIProtocols.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/4/25.
//

import CoreMIDI

/// The base protocol for all MIDI types that can be referred to by a `UInt32` value.
///
/// All other `ARMIDI` protocols inherit from `MIDIReferable`.
///
/// `UInt32` conforms to `MIDIReferable`. A `UInt32`'s `midiRef` property is its own value. `UInt32` also conforms to all other protocols that inherit from `MIDIReferable`. Thus, any of the methods defined by the ineriting protocols can be called directly on a `UInt32` value.
public protocol MIDIReferable {
    
    /// The `UInt32` value used to refer to the MIDI object.
    var midiRef: UInt32 { get }
}

extension UInt32: MIDIReferable, MIDIObjectReferable, MIDIDeviceReferable {
    
    /// Returns `self` for all `UInt32` values.
    ///
    /// `midiRef` is required by `MIDIReferable`.
    public var midiRef: UInt32 {
        return self
    }
}

/// A protocol for MIDI objects.
public protocol MIDIObjectReferable: MIDIReferable {
    
    /// Retrieves the identified `String` property.
    ///
    /// - Parameter property: A constant defined by `CoreMIDI` for referring to MIDI object properties.
    ///
    /// - Throws: `MIDIError`
    ///
    /// - Returns: A `String` value, or `nil` if the property is not set for the object.
    func getStringProperty(_ property: CFString) throws -> String?
}

public protocol MIDIDeviceReferable: MIDIObjectReferable {
    
    /// The number of MIDI entities for the MIDI device.
    ///
    /// - Returns: The number of MIDI entities for the MIDI device..
    func numberOfEntities() -> Int
    
    /// The MIDI entity at the provided index.
    ///
    /// - Parameter index: The index of the entity to return.
    ///
    /// - Returns: The `MIDIEntityRef` of the MIDI entity at the provided index.
    func entity(atIndex index: Int) -> MIDIEntityRef
    
    /// An array of the MIDI entities for this device..
    ///
    /// - Returns: An `Array<MIDIEntityRef>` of all the MIDI entities for this device..
    func entities() -> [MIDIEntityRef]
}
