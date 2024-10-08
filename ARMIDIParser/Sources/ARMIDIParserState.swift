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
    
    public init() {
        self = .parsing(bytes: Data(), index: 0)
    }
    
    public var hasBytesLeft: Bool { get
        {
            switch self {
                
            case    .parsing(let bs, let i),
                    .parsingData(let bs, let i, _, _, _, _),
                    .parsingSystemExclusiveMessage(let bs, let i, _),
                    .parsingDataTail(let bs, let i, _),
                    .running(let bs, let i, _):
                return i < bs.count
            }
        }
    }
    
    public func addBytes(_ bytes: [UInt8]) -> ARMIDIParserState {
        switch self {
            
        case .parsing(var bs, let i):
            bs.append(contentsOf: bytes)
            return .parsing(bytes: bs, index: i)
            
        case .parsingData(var bs, let i, let sB, let d, let eDC, let cDC):
            bs.append(contentsOf: bytes)
            return .parsingData(bytes: bs, index: i, statusByte: sB, data: d, expectedDataCount: eDC, currentDataCount: cDC)
            
        case .parsingSystemExclusiveMessage(var bs, let i, let d):
            bs.append(contentsOf: bytes)
            return .parsingSystemExclusiveMessage(bytes: bs, index: i, data: d)
            
        case .parsingDataTail(var bs, let i, let d):
            bs.append(contentsOf: bytes)
            return .parsingDataTail(bytes: bs, index: i, data: d)
            
        case .running(var bs, let i, let sB):
            bs.append(contentsOf: bytes)
            return .running(bytes: bs, index: i, statusByte: sB)
        }
    }
}
