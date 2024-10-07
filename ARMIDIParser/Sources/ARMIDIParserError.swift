//
//  ARMIDIParserError.swift
//  
//
//  Created by Aaron Rasmussen on 10/5/24.
//

public enum ARMIDIParserError: Error {
    
    case undefinedSystemRealTimeStatusByte0xF9
    case undefinedSystemRealTimeStatusByte0xFD
    case undefinedSystemCommonStatusByte0xF4
    case undefinedSystemCommonStatusByte0xF5
    case unexpectedSystemCommonStatusByte(state: ARMIDIParserState)
    case unexpectedSystemExclusiveStatusByte(state: ARMIDIParserState)
    case unexpectedChannelStatusByte(state: ARMIDIParserState)
}
