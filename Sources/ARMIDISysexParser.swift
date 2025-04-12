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
    
    public init() { }
    
    public init(parserHandler: @escaping ([UInt8]) -> Void) {
        self.handle = parserHandler
    }
    
    /// A method for handling data to be parsed.
    ///
    /// - Parameter bytes: An array of bytes to be parsed.`
    public func parse(_ bytes: [UInt8]) {
        
        bytes.forEach { byte in
            
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
    
    /// Sets the parser handler.
    ///
    /// The parser handler is called when the parser has received a complete Sysex message.
    ///
    /// - Parameter handler: A closure that takes an array of `UInt8` bytes and returns `Void`.
    public func setParserHandler(_ handler: @escaping ([UInt8]) -> Void) {
        self.handle = handler
    }
}
