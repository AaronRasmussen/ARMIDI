//
//  ARMIDIParserState.swift
//  
//
//  Created by Aaron Rasmussen on 10/5/24.
//

public enum ARMIDIParserState {
    
    case parsing(bytes: Data, index: Int)
    case parsingData(bytes: Data, index: Int, statusByte: UInt8, data: Data, expectedDataCount: Int, currentDataCount: Int)
    case parsingSystemExclusiveMessage(bytes: Data, index: Int, data: Data)
    case parsingDataTail(bytes: Data, index: Int, data: Data)
    case running(bytes: Data, index: Int, statusByte: UInt8)
}
