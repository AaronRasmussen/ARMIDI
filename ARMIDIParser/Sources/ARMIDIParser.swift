//
//  ARMIDIParser.swift
//  
//
//  Created by Aaron Rasmussen on 10/5/24.
//



public class ARMIDIParser: ARMIDIParserType {
    
    public var currentState = ARMIDIParserState()
    
    public convenience init() {
        self.init(state: ARMIDIParserState())
    }
    
    init(state: ARMIDIParserState) {
        self.currentState = state
    }
    
    // Override this function
    public func process(midiMessage: ARMIDIParserMessage?) {
        return
    }
}
