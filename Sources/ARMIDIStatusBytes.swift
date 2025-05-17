//
//  ARStatusBytes.swift
//
//
//  Created by Aaron Rasmussen on 2/7/25.
//

// Voice Note Off
public let kChannel01NoteOff: UInt8             = 0x80  // 0b10000000
public let kChannel02NoteOff: UInt8             = 0x81  // 0b10000001
public let kChannel03NoteOff: UInt8             = 0x82  // 0b10000010
public let kChannel04NoteOff: UInt8             = 0x83  // 0b10000011
public let kChannel05NoteOff: UInt8             = 0x84  // 0b10000100
public let kChannel06NoteOff: UInt8             = 0x85  // 0b10000101
public let kChannel07NoteOff: UInt8             = 0x86  // 0b10000110
public let kChannel08NoteOff: UInt8             = 0x87  // 0b10000111
public let kChannel09NoteOff: UInt8             = 0x88  // 0b10001000
public let kChannel10NoteOff: UInt8             = 0x89  // 0b10001001
public let kChannel11NoteOff: UInt8             = 0x8A  // 0b10001010
public let kChannel12NoteOff: UInt8             = 0x8B  // 0b10001011
public let kChannel13NoteOff: UInt8             = 0x8C  // 0b10001100
public let kChannel14NoteOff: UInt8             = 0x8D  // 0b10001101
public let kChannel15NoteOff: UInt8             = 0x8E  // 0b10001110
public let kChannel16NoteOff: UInt8             = 0x8F  // 0b10001111

// Voice Note On
public let kChannel01NoteOn: UInt8              = 0x90  // 0b10010000
public let kChannel02NoteOn: UInt8              = 0x91  // 0b10010001
public let kChannel03NoteOn: UInt8              = 0x92  // 0b10010010
public let kChannel04NoteOn: UInt8              = 0x93  // 0b10010011
public let kChannel05NoteOn: UInt8              = 0x94  // 0b10010100
public let kChannel06NoteOn: UInt8              = 0x95  // 0b10010101
public let kChannel07NoteOn: UInt8              = 0x96  // 0b10010110
public let kChannel08NoteOn: UInt8              = 0x97  // 0b10010111
public let kChannel09NoteOn: UInt8              = 0x98  // 0b10011000
public let kChannel10NoteOn: UInt8              = 0x99  // 0b10011001
public let kChannel11NoteOn: UInt8              = 0x9A  // 0b10011010
public let kChannel12NoteOn: UInt8              = 0x9B  // 0b10011011
public let kChannel13NoteOn: UInt8              = 0x9C  // 0b10011100
public let kChannel14NoteOn: UInt8              = 0x9D  // 0b10011101
public let kChannel15NoteOn: UInt8              = 0x9E  // 0b10011110
public let kChannel16NoteOn: UInt8              = 0x9F  // 0b10011111

// Voice Poly Key Pressure
public let kChannel01PolyKeyPressure: UInt8             = 0xA0  // 0b10100000
public let kChannel02PolyKeyPressure: UInt8             = 0xA1  // 0b10100001
public let kChannel03PolyKeyPressure: UInt8             = 0xA2  // 0b10100010
public let kChannel04PolyKeyPressure: UInt8             = 0xA3  // 0b10100011
public let kChannel05PolyKeyPressure: UInt8             = 0xA4  // 0b10100100
public let kChannel06PolyKeyPressure: UInt8             = 0xA5  // 0b10100101
public let kChannel07PolyKeyPressure: UInt8             = 0xA6  // 0b10100110
public let kChannel08PolyKeyPressure: UInt8             = 0xA7  // 0b10100111
public let kChannel09PolyKeyPressure: UInt8             = 0xA8  // 0b10101000
public let kChannel10PolyKeyPressure: UInt8             = 0xA9  // 0b10101001
public let kChannel11PolyKeyPressure: UInt8             = 0xAA  // 0b10101010
public let kChannel12PolyKeyPressure: UInt8             = 0xAB  // 0b10101011
public let kChannel13PolyKeyPressure: UInt8             = 0xAC  // 0b10101100
public let kChannel14PolyKeyPressure: UInt8             = 0xAD  // 0b10101101
public let kChannel15PolyKeyPressure: UInt8             = 0xAE  // 0b10101110
public let kChannel16PolyKeyPressure: UInt8             = 0xAF  // 0b10101111

// Voice Control Change
public let kChannel01ControlChange: UInt8             = 0xB0  // 0b10110000
public let kChannel02ControlChange: UInt8             = 0xB1  // 0b10110001
public let kChannel03ControlChange: UInt8             = 0xB2  // 0b10110010
public let kChannel04ControlChange: UInt8             = 0xB3  // 0b10110011
public let kChannel05ControlChange: UInt8             = 0xB4  // 0b10110100
public let kChannel06ControlChange: UInt8             = 0xB5  // 0b10110101
public let kChannel07ControlChange: UInt8             = 0xB6  // 0b10110110
public let kChannel08ControlChange: UInt8             = 0xB7  // 0b10110111
public let kChannel09ControlChange: UInt8             = 0xB8  // 0b10111000
public let kChannel10ControlChange: UInt8             = 0xB9  // 0b10111001
public let kChannel11ControlChange: UInt8             = 0xBA  // 0b10111010
public let kChannel12ControlChange: UInt8             = 0xBB  // 0b10111011
public let kChannel13ControlChange: UInt8             = 0xBC  // 0b10111100
public let kChannel14ControlChange: UInt8             = 0xBD  // 0b10111101
public let kChannel15ControlChange: UInt8             = 0xBE  // 0b10111110
public let kChannel16ControlChange: UInt8             = 0xBF  // 0b10111111

// Voice Program Change
public let kChannel01ProgramChange: UInt8             = 0xC0  // 0b11000000
public let kChannel02ProgramChange: UInt8             = 0xC1  // 0b11000001
public let kChannel03ProgramChange: UInt8             = 0xC2  // 0b11000010
public let kChannel04ProgramChange: UInt8             = 0xC3  // 0b11000011
public let kChannel05ProgramChange: UInt8             = 0xC4  // 0b11000100
public let kChannel06ProgramChange: UInt8             = 0xC5  // 0b11000101
public let kChannel07ProgramChange: UInt8             = 0xC6  // 0b11000110
public let kChannel08ProgramChange: UInt8             = 0xC7  // 0b11000111
public let kChannel09ProgramChange: UInt8             = 0xC8  // 0b11001000
public let kChannel10ProgramChange: UInt8             = 0xC9  // 0b11001001
public let kChannel11ProgramChange: UInt8             = 0xCA  // 0b11001010
public let kChannel12ProgramChange: UInt8             = 0xCB  // 0b11001011
public let kChannel13ProgramChange: UInt8             = 0xCC  // 0b11001100
public let kChannel14ProgramChange: UInt8             = 0xCD  // 0b11001101
public let kChannel15ProgramChange: UInt8             = 0xCE  // 0b11001110
public let kChannel16ProgramChange: UInt8             = 0xCF  // 0b11001111

// Voice Channel Pressure
public let kChannel01ChannelPressure: UInt8             = 0xD0  // 0b11010000
public let kChannel02ChannelPressure: UInt8             = 0xD1  // 0b11010001
public let kChannel03ChannelPressure: UInt8             = 0xD2  // 0b11010010
public let kChannel04ChannelPressure: UInt8             = 0xD3  // 0b11010011
public let kChannel05ChannelPressure: UInt8             = 0xD4  // 0b11010100
public let kChannel06ChannelPressure: UInt8             = 0xD5  // 0b11010101
public let kChannel07ChannelPressure: UInt8             = 0xD6  // 0b11010110
public let kChannel08ChannelPressure: UInt8             = 0xD7  // 0b11010111
public let kChannel09ChannelPressure: UInt8             = 0xD8  // 0b11011000
public let kChannel10ChannelPressure: UInt8             = 0xD9  // 0b11011001
public let kChannel11ChannelPressure: UInt8             = 0xDA  // 0b11011010
public let kChannel12ChannelPressure: UInt8             = 0xDB  // 0b11011011
public let kChannel13ChannelPressure: UInt8             = 0xDC  // 0b11011100
public let kChannel14ChannelPressure: UInt8             = 0xDD  // 0b11011101
public let kChannel15ChannelPressure: UInt8             = 0xDE  // 0b11011110
public let kChannel16ChannelPressure: UInt8             = 0xDF  // 0b11011111

// Voice Pitch Bend
public let kChannel01PitchBend: UInt8             = 0xE0  // 0b11100000
public let kChannel02PitchBend: UInt8             = 0xE1  // 0b11100001
public let kChannel03PitchBend: UInt8             = 0xE2  // 0b11100010
public let kChannel04PitchBend: UInt8             = 0xE3  // 0b11100011
public let kChannel05PitchBend: UInt8             = 0xE4  // 0b11100100
public let kChannel06PitchBend: UInt8             = 0xE5  // 0b11100101
public let kChannel07PitchBend: UInt8             = 0xE6  // 0b11100110
public let kChannel08PitchBend: UInt8             = 0xE7  // 0b11100111
public let kChannel09PitchBend: UInt8             = 0xE8  // 0b11101000
public let kChannel10PitchBend: UInt8             = 0xE9  // 0b11101001
public let kChannel11PitchBend: UInt8             = 0xEA  // 0b11101010
public let kChannel12PitchBend: UInt8             = 0xEB  // 0b11101011
public let kChannel13PitchBend: UInt8             = 0xEC  // 0b11101100
public let kChannel14PitchBend: UInt8             = 0xED  // 0b11101101
public let kChannel15PitchBend: UInt8             = 0xEE  // 0b11101110
public let kChannel16PitchBend: UInt8             = 0xEF  // 0b11101111

// System Exclusinve
public let kSystemExclusive: UInt8                  = 0xF0  // 0b11110000

// System Common
public let kSystemCommonTimeCode: UInt8             = 0xF1  // 0b11110001
public let kSystemCommonSongPosition: UInt8         = 0xF2  // 0b11110010
public let kSystemCommonSongSelect: UInt8           = 0xF3  // 0b11110011
public let kSystemCommonUndefined0xF4: UInt8        = 0xF4  // 0b11110100
public let kSystemCommonUndefined0xF5: UInt8        = 0xF5  // 0b11110101
public let kSystemCommonTuneRequest: UInt8          = 0xF6  // 0b11110110
public let kSystemCommonEOX: UInt8                  = 0xF7  // 0b11110111

// System Real Time
public let kSystemRealTimeTimingClock: UInt8        = 0xF8  // 0b11111000
public let kSystemRealTimeUndefined0xF9: UInt8      = 0xF9  // 0b11111001
public let kSystemRealTimeStart: UInt8              = 0xFA  // 0b11111010
public let kSystemRealTimeContinue: UInt8           = 0xFB  // 0b11111011
public let kSystemRealTimeStop: UInt8               = 0xFC  // 0b11111100
public let kSystemRealTimeUndefined0xFD: UInt8      = 0xFD  // 0b11111101
public let kSystemRealTimeActiveSensing: UInt8      = 0xFE  // 0b11111110
public let kSystemRealTimeSystemReset: UInt8        = 0xFF  // 0b11111111

extension UInt8 {
    
    public var isStatusByte: Bool {
        (self & 0x80) != 0
    }
    
    public var isChannelStatusByte: Bool {
        isStatusByte && (self <= 0xEF)
    }
    
    public var isChannel01StatusByte: Bool {
        isChannelStatusByte && (self & 0x0F == 0x00)
    }
    
    public var isChannel02StatusByte: Bool {
        isChannelStatusByte && (self & 0x0F == 0x01)
    }
    
    public var isChannel03StatusByte: Bool {
        isChannelStatusByte && (self & 0x0F == 0x02)
    }
    
    public var isChannel04StatusByte: Bool {
        isChannelStatusByte && (self & 0x0F == 0x03)
    }
    
    public var isChannel05StatusByte: Bool {
        isChannelStatusByte && (self & 0x0F == 0x04)
    }
    
    public var isChannel06StatusByte: Bool {
        isChannelStatusByte && (self & 0x0F == 0x05)
    }
    
    public var isChannel07StatusByte: Bool {
        isChannelStatusByte && (self & 0x0F == 0x06)
    }
    
    public var isChannel08StatusByte: Bool {
        isChannelStatusByte && (self & 0x0F == 0x07)
    }
    
    public var isChannel09StatusByte: Bool {
        isChannelStatusByte && (self & 0x0F == 0x08)
    }
    
    public var isChannel10StatusByte: Bool {
        isChannelStatusByte && (self & 0x0F == 0x09)
    }
    
    public var isChannel11StatusByte: Bool {
        isChannelStatusByte && (self & 0x0F == 0x0A)
    }
    
    public var isChannel12StatusByte: Bool {
        isChannelStatusByte && (self & 0x0F == 0x0B)
    }
    
    public var isChannel13StatusByte: Bool {
        isChannelStatusByte && (self & 0x0F == 0x0C)
    }
    
    public var isChannel14StatusByte: Bool {
        isChannelStatusByte && (self & 0x0F == 0x0D)
    }
    
    public var isChannel15StatusByte: Bool {
        isChannelStatusByte && (self & 0x0F == 0x0E)
    }
    
    public var isChannel16StatusByte: Bool {
        isChannelStatusByte && (self & 0x0F == 0x0F)
    }
    
    public var isNoteOffStatusByte: Bool {
         (self >= 0x80) && (self <= 0x8F)
    }
    
    public var isNoteOnStatusByte: Bool {
         (self >= 0x90) && (self <= 0x9F)
    }
    
    public var isPolyKeyPressureStatusByte: Bool {
         (self >= 0xA0) && (self <= 0xAF)
    }
    
    public var isControlChangeStatusByte: Bool {
         (self >= 0xB0) && (self <= 0xBF)
    }
    
    public var isProgramChangeStatusByte: Bool {
         (self >= 0xC0) && (self <= 0xCF)
    }
    
    public var isChannelPressureStatusByte: Bool {
         (self >= 0xD0) && (self <= 0xDF)
    }
    
    public var isPitchBendStatusByte: Bool {
         (self >= 0xE0) && (self <= 0xEF)
    }
    
    public var isSystemStatusByte: Bool {
        isStatusByte && (self >= 0xF0)
    }
    
    public var isUndefinedStatusByte: Bool {
         (self != 0xF4) && (self != 0xF5) && (self != 0xF9) && (self != 0xFD)
    }
    
    public var isSystemCommonStatusByte: Bool {
         (self >= 0xF1) && (self <= 0xF7) && !self.isUndefinedStatusByte
    }
    
    public var isSystemRealTimeStatusByte: Bool {
         (self >= 0xF8) && (self <= 0xFF) && !self.isUndefinedStatusByte
    }
}
