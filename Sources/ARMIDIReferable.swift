//
//  ARMIDIReferable.swift
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

extension UInt32: MIDIReferable {
    
    /// Returns `self` for all `UInt32` values.
    ///
    /// `midiRef` is required by `MIDIReferable`.
    public var midiRef: UInt32 {
        return self
    }
}
