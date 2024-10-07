//
//  ARMIDIParserUInt8.swift
//  Pods
//
//  Created by Aaron Rasmussen on 10/7/24.
//

public let StatusByteNoteOff: UInt8                 = 0x80
public let StatusByteNoteOn: UInt8                  = 0x90
public let StatusBytePolyphonicAftertouch: UInt8    = 0xA0
public let StatusByteControlChangeOrMode: UInt8     = 0xB0
public let StatusByteProgramChange: UInt8           = 0xC0
public let StatusByteChannelAftertouch: UInt8       = 0xD0
public let StatusBytePitchBendChange: UInt8         = 0xE0
public let StatusByteSystemExclusive: UInt8         = 0xF0
public let StatusByteSystemCommonMIDITimeCode       = 0xF1
public let StatusByteSystemCommonSongPosition       = 0xF2
public let StatusByteSystemCommonSongSelect         = 0xF3
public let StatusByteSystemCommonUndefined_0xF4     = 0xF4
public let StatusByteSystemCommonUndefined_0xF5     = 0xF5
public let StatusByteSystemCommonTuneRequest        = 0xF6
public let StatusByteSystemCommonEOX                = 0xF7
public let StatusByteSystemRealTimeTimingClock      = 0xF8
public let StatusByteSystemRealTimeUndefined_0xF9   = 0xF9
public let StatusByteSystemRealTimeStart            = 0xFA
public let StatusByteSystemRealTimeContinue         = 0xFB
public let StatusByteSystemRealTimeStop             = 0xFC
public let StatusByteSystemRealTimeUndefined_0xFD   = 0xFD
public let StatusByteSystemRealTimeActiveSensing    = 0xFE
public let StatusByteSystemRealTimeSystemReset      = 0xFF



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
