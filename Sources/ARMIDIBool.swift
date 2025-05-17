//
//  ARMIDIBool.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 4/12/25.
//

extension Bool {
    
    /// This is a computed property that returns `1` for `true` or `0` for `false`.
    ///
    /// It is used for compatibility with boolean properties that are stored by a synthesizer using a `UInt8` value.
    public var uint8: UInt8 { self ? 1 : 0 }
    
    
    /// Initialize a `Bool` value using a `UInt8`  value.
    ///
    /// A `0` returns  `false`. All other values return `true`.
    public init(_ value: UInt8) {
        self = value != 0
    }
}
