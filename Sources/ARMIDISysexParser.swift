//
//  SysexParser.swift
//  ARMIDISysex
//
//  Created by Aaron Rasmussen on 2/25/25.
//

import CoreMIDI
import ARMIDIError

/// A parser for system exclusive MIDI messages.
///
/// The parser looks only for system exclusive MIDI messages. Messages will be handled by the `sysexHandler` supplied when the parser is initialized.
public class SysexParser {
    
    private enum State {
        case waiting
        case receiving
    }
    
    private var handle: (([UInt8]) -> Void)?
    
    private var state: State = .waiting
    private var buffer: [UInt8] = []
    
    /// A method for handling data to be parsed.
    ///
    /// - Parameter data: An array of bytes to be parsed.`
    public func parse(_ data: [UInt8]) {
        
        data.forEach { byte in
            
            switch self.state {
                
            case .waiting:
                
                if byte == kSystemExclusive {
                    self.state = .receiving
                }
                
            case .receiving:
                
                switch byte {
                    
                case kSystemExclusive:
                    self.buffer = []
                    
                case kSystemCommonEOX:
                    self.handle?(buffer)
                    self.state = .waiting
                    self.buffer = []
                    
                case let b where !b.isStatusByte:
                    self.buffer.append(b)
                    
                case let b where b.isSystemRealTimeStatusByte:
                    break
                    
                default:
                    self.state = .waiting
                    self.buffer = []
                }
            }
        }
    }
    
    public func setParserHandler(_ handler: @escaping ([UInt8]) -> Void) {
        self.handle = handler
    }
}
