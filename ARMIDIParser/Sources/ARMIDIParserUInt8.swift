//
//  ARMIDIParserUInt8.swift
//  Pods
//
//  Created by Aaron Rasmussen on 10/7/24.
//

public let StatusByteNoteOff: UInt8                     = 0x80
public let StatusByteNoteOn: UInt8                      = 0x90
public let StatusBytePolyphonicAftertouch: UInt8        = 0xA0
public let StatusByteControlChangeOrMode: UInt8         = 0xB0
public let StatusByteProgramChange: UInt8               = 0xC0
public let StatusByteChannelAftertouch: UInt8           = 0xD0
public let StatusBytePitchBendChange: UInt8             = 0xE0
public let StatusByteSystemExclusive: UInt8             = 0xF0
public let StatusByteSystemCommonMIDITimeCode: UInt8    = 0xF1
public let StatusByteSystemCommonSongPosition: UInt8    = 0xF2
public let StatusByteSystemCommonSongSelect: UInt8      = 0xF3
public let StatusByteSystemCommonUndefined_0xF4: UInt8      = 0xF4
public let StatusByteSystemCommonUndefined_0xF5: UInt8      = 0xF5
public let StatusByteSystemCommonTuneRequest: UInt8     = 0xF6
public let StatusByteSystemCommonEOX: UInt8             = 0xF7
public let StatusByteSystemRealTimeTimingClock: UInt8   = 0xF8
public let StatusByteSystemRealTimeUndefined_0xF9: UInt8    = 0xF9
public let StatusByteSystemRealTimeStart: UInt8         = 0xFA
public let StatusByteSystemRealTimeContinue: UInt8      = 0xFB
public let StatusByteSystemRealTimeStop: UInt8          = 0xFC
public let StatusByteSystemRealTimeUndefined_0xFD: UInt8    = 0xFD
public let StatusByteSystemRealTimeActiveSensing: UInt8 = 0xFE
public let StatusByteSystemRealTimeSystemReset: UInt8   = 0xFF

public let DataByteModeAllSoundsOff: UInt8              = 0x70
public let DataByteModeResetAllControllers: UInt8       = 0x71
public let DataByteModeLocalControl: UInt8              = 0x72
public let DataByteModeAllNotesOff: UInt8               = 0x73
public let DataByteModeOmniModeOff: UInt8               = 0x74
public let DataByteModeOmniModeOn: UInt8                = 0x75
public let DataByteModeMonoModeOn: UInt8                = 0x76
public let DataByteModePolyModeOn: UInt8                = 0x77

extension UInt8 {
    
    public var isStatusByte: Bool {
        get {
            return self >= StatusByteNoteOff
        }
    }
    
    public var isDataByte: Bool {
        get {
            return !self.isStatusByte
        }
    }
    
    public var isSystemStatusByte: Bool {
        get {
            return self >= StatusByteSystemExclusive
        }
    }
    
    public var isChannelStatusByte: Bool {
        get {
            return self.isStatusByte && self < StatusByteSystemExclusive
        }
    }
    
    public var isSystemRealTimeStatusByte: Bool {
        get {
            return self >= StatusByteSystemRealTimeTimingClock
        }
    }
     
    public var isSystemCommonStatusByte: Bool {
        get {
            return self > StatusByteSystemExclusive && !self.isSystemRealTimeStatusByte
        }
    }
    
    public var isSystemExclusiveStatusByte: Bool {
        get {
            return self == StatusByteSystemExclusive
        }
    }
    
    public var channelMessageStatusBits: UInt8 {
        return self & 0xF0
    }
    
    public var channelMessageChannelBits: UInt8 {
        return self & 0x0F
    }
    
    public var channel: Int {
        return Int(self.channelMessageChannelBits) + 1
    }
}
