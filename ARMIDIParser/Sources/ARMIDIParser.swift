//
//  ARMIDIParser.swift
//  
//
//  Created by Aaron Rasmussen on 10/5/24.
//

public class ARMIDIParser: ARMIDIParserType {
    
    var currentState: ARMIDIParserState? = nil
    
    public func handle(data: [UInt8]) throws {
        
        var state: ARMIDIParserState = {
            
            switch self.currentState {
                
            case .parsing(var bs, let i):
                bs.append(contentsOf: data)
                return .parsing(bytes: bs, index: i)
                
            case .parsingData(var bs, let i, let sB, let d, let eDC, let cDC):
                bs.append(contentsOf: data)
                return .parsingData(bytes: bs, index: i, statusByte: sB, data: d, expectedDataCount: eDC, currentDataCount: cDC)
                
            case .parsingSystemExclusiveMessage(var bs, let i, let d):
                bs.append(contentsOf: data)
                return .parsingSystemExclusiveMessage(bytes: bs, index: i, data: d)
                
            case .parsingDataTail(var bs, let i, let d):
                bs.append(contentsOf: data)
                return .parsingDataTail(bytes: bs, index: i, data: d)
                
            case .running(var bs, let i, let sB):
                bs.append(contentsOf: data)
                return .running(bytes: bs, index: i, statusByte: sB)
                
            case nil:
                return .parsing(bytes: Data(data), index: 0)
            }
        }()
        
        self.currentState = state
        
        repeat {
            
            let (m, s) = try parseMIDI(state: state)
            
            if let m = m {
                print(m)
            }
            
            switch s {
            case    .parsing(let bytes, let i),
                    .parsingData(bytes: let bytes, let i, _, _, _, _),
                    .parsingSystemExclusiveMessage(let bytes, let i, _),
                    .parsingDataTail(let bytes, let i, _),
                    .running(let bytes, let i, _):
                state = s
                self.currentState = i < bytes.count ? s : nil
            }
            
        } while self.currentState != nil
    }
}



extension UInt8 {
    
    public var isStatusByte: Bool {
        get {
            return self > 0x7F
        }
    }
    
    public var isDataByte: Bool {
        get {
            return !self.isStatusByte
        }
    }
    
    public var isSystemStatusByte: Bool {
        get {
            return self >= 0xF0
        }
    }
    
    public var isChannelStatusByte: Bool {
        get {
            return self.isStatusByte && self < 0xF0
        }
    }
    
    public var isSystemRealTimeStatusByte: Bool {
        get {
            return self >= 0xF8
        }
    }
     
    public var isSystemCommonStatusByte: Bool {
        get {
            return self < 0xF8 && self > 0xF0
        }
    }
    
    public var isSystemExclusiveStatusByte: Bool {
        get {
            return self == 0xF0
        }
    }
}
