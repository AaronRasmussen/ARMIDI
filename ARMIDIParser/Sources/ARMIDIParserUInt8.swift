//
//  ARMIDIParserUInt8.swift
//  Pods
//
//  Created by Aaron Rasmussen on 10/7/24.
//


extension UInt8 {
    
    public var isStatusByte: Bool {
        get {
            return self >= kStatusByteNoteOff
        }
    }
    
    public var isDataByte: Bool {
        get {
            return !self.isStatusByte
        }
    }
    
    public var isSystemStatusByte: Bool {
        get {
            return self >= kStatusByteSystemExclusive
        }
    }
    
    public var isChannelStatusByte: Bool {
        get {
            return self.isStatusByte && self < kStatusByteSystemExclusive
        }
    }
    
    public var isSystemRealTimeStatusByte: Bool {
        get {
            return self >= kStatusByteSystemRealTimeTimingClock
        }
    }
     
    public var isSystemCommonStatusByte: Bool {
        get {
            return self > kStatusByteSystemExclusive && !self.isSystemRealTimeStatusByte
        }
    }
    
    public var isSystemExclusiveStatusByte: Bool {
        get {
            return self == kStatusByteSystemExclusive
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
