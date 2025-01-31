//
//  ARMIDIServices+SysEx.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 1/31/25.
//

import CoreMIDI

public struct ParsedSysExUMP {
    public let group: UInt32
    public let status: UInt32
    public let numBytes: UInt32
    public let data: [UInt8]
    
    public init(group: UInt32, status: UInt32, numBytes: UInt32, data: [UInt8]) {
        self.group = group
        self.status = status
        self.numBytes = numBytes
        self.data = data
    }
}

@available(macOS 11.0, *)
public func parseSysExUMP(words: MIDIEventPacket.WordCollection) -> ParsedSysExUMP {
    
    let word64 = (UInt64(words[0]) << 32) | UInt64(words[1])
    
    let group: UInt32       = UInt32(word64 >> 56) & 0xf
    let status: UInt32      = UInt32(word64 >> 52) & 0xf
    let numBytes: UInt32    = UInt32(word64 >> 48) & 0xf
    
    let data: [UInt8] = (0..<numBytes).map { index in
        UInt8(word64 >> (40 - 8 * index) & 0xff)
    }
    
    return ParsedSysExUMP(group: group, status: status, numBytes: numBytes, data: data)
}
