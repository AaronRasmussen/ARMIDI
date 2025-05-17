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
/// The parser looks only for system exclusive MIDI messages. Messages will be handled by the `parserHandler`closure supplied when the parser is initialized.
public class SysexParser {
    
    private enum State {
        case waiting
        case receiving
    }
    
    private var handle: (([UInt8]) -> Void)? = nil
    
    private var state: State = .waiting
    private var buffer: [UInt8] = []
    
    /// Initialize a `SysexParser` without a handler closure.
    ///
    /// A parser handler will have to be supplied using the `setSysexParser(_:)` method before the parser can be used.
    public init() { }
    
    /// Initizlize a `SysexParser` using the supplied `parserHandler` closure.
    ///
    /// The `parserHandler` closure is called when the parser has received a complete system exclusive
    /// MIDI message. The closure takes an array of bytes excluding the initial system exclusive data byte
    /// and the `EOX` byte.
    public init(parserHandler: @escaping ([UInt8]) -> Void) {
        self.handle = parserHandler
    }
    
    /// A method for handling data to be parsed.
    ///
    /// - Parameter bytes: An array of bytes to be parsed.`
    public func parse(_ bytes: [UInt8]) {
        
        guard
            let handle = handle
        else {
            fatalError()
        }
        
        bytes.forEach { byte in
            
            switch state {
                
            case .waiting:
                
                if byte == kSystemExclusive {
                    state = .receiving
                }
                
            case .receiving:
                
                switch byte {
                    
                case kSystemExclusive:
                    buffer = []
                    
                case kSystemCommonEOX:
                    handle(buffer)
                    state = .waiting
                    buffer = []
                    
                case let b where !b.isStatusByte:
                    buffer.append(b)
                    
                case let b where b.isSystemRealTimeStatusByte:
                    break
                    
                default:
                    state = .waiting
                    buffer = []
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
        handle = handler
    }
}
