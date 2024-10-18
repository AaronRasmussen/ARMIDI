//
//  ARMIDIParser+Constants.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 10/17/24.
//

public let kStatusByteNoteOff: UInt8                         = 0x80
public let kStatusByteNoteOn: UInt8                          = 0x90
public let kStatusBytePolyphonicAftertouch: UInt8            = 0xA0
public let kStatusByteControlChangeOrMode: UInt8             = 0xB0
public let kStatusByteProgramChange: UInt8                   = 0xC0
public let kStatusByteChannelAftertouch: UInt8               = 0xD0
public let kStatusBytePitchBendChange: UInt8                 = 0xE0
public let kStatusByteSystemExclusive: UInt8                 = 0xF0
public let kStatusByteSystemCommonMIDITimeCode: UInt8        = 0xF1
public let kStatusByteSystemCommonSongPosition: UInt8        = 0xF2
public let kStatusByteSystemCommonSongSelect: UInt8          = 0xF3
public let kStatusByteSystemCommonUndefined_0xF4: UInt8      = 0xF4
public let kStatusByteSystemCommonUndefined_0xF5: UInt8      = 0xF5
public let kStatusByteSystemCommonTuneRequest: UInt8         = 0xF6
public let kStatusByteSystemCommonEOX: UInt8                 = 0xF7
public let kStatusByteSystemRealTimeTimingClock: UInt8       = 0xF8
public let kStatusByteSystemRealTimeUndefined_0xF9: UInt8    = 0xF9
public let kStatusByteSystemRealTimeStart: UInt8             = 0xFA
public let kStatusByteSystemRealTimeContinue: UInt8          = 0xFB
public let kStatusByteSystemRealTimeStop: UInt8              = 0xFC
public let kStatusByteSystemRealTimeUndefined_0xFD: UInt8    = 0xFD
public let kStatusByteSystemRealTimeActiveSensing: UInt8     = 0xFE
public let kStatusByteSystemRealTimeSystemReset: UInt8       = 0xFF

public let kDataByteModeAllSoundsOff: UInt8              = 0x70
public let kDataByteModeResetAllControllers: UInt8       = 0x71
public let kDataByteModeLocalControl: UInt8              = 0x72
public let kDataByteModeAllNotesOff: UInt8               = 0x73
public let kDataByteModeOmniModeOff: UInt8               = 0x74
public let kDataByteModeOmniModeOn: UInt8                = 0x75
public let kDataByteModeMonoModeOn: UInt8                = 0x76
public let kDataByteModePolyModeOn: UInt8                = 0x77
