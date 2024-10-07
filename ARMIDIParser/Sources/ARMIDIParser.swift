//
//  ARMIDIParser.swift
//  
//
//  Created by Aaron Rasmussen on 10/5/24.
//

public class ARMIDIParser: ARMIDIParserType {
    
    public var currentState: ARMIDIParserState = .parsing(bytes: Data(), index: 0)
    
    public init() { }
    
    public func handle(data: [UInt8]) throws {
        
        self.currentState = self.currentState.addBytes(bytes: data)
        
        var bytesLeft = !data.isEmpty
        
        repeat {
            
            let (m, s) = try parseMIDI(state: self.currentState)
            
            if let m = m {
                print(m)
            }
            
            switch s {
                
            case    .parsing(let bytes, let i),
                    .parsingData(bytes: let bytes, let i, _, _, _, _),
                    .parsingSystemExclusiveMessage(let bytes, let i, _),
                    .parsingDataTail(let bytes, let i, _),
                    .running(let bytes, let i, _):
                
                currentState = s
                bytesLeft = i < bytes.count
            }
            
        } while bytesLeft
    }
}
