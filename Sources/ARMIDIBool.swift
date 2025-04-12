//
//  ARMIDIBool.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 4/12/25.
//

extension Bool {
    
    public var uint8: UInt8 { self ? 1 : 0 }
    
    public init(_ value: UInt8) {
        self = value != 0
    }
}
