//
//  ARMIDIParseError.swift
//  
//
//  Created by Aaron Rasmussen on 10/5/24.
//

public enum ARMIDIParseError: Error {
    
    case undefinedSystemRealTimeStatusByte0xF9
    case undefinedSystemRealTimeStatusByte0xFD
    case undefinedSystemCommonStatusByte0xF4
    case undefinedSystemCommonStatusByte0xF5
    case unexpectedSystemCommonStatusByte(state: MIDIState)
    case unexpectedSystemExclusiveStatusByte(state: MIDIState)
    case unexpectedChannelStatusByte(state: MIDIState)
}
