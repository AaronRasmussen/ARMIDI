//
//  ARMIDIParser.swift
//  
//
//  Created by Aaron Rasmussen on 10/5/24.
//



public protocol ARMIDIParser {
    func parseMIDI(state: ARMIDIParseState) throws -> (ARMIDIMessage?, ARMIDIParseState)
}

extension ARMIDIParser {
    
    public func parseMIDI(state: ARMIDIParseState) throws -> (ARMIDIMessage?, ARMIDIParseState) {
        
        switch state {
        case    .parsing(let bytes, let i),
                .parsingData(bytes: let bytes, let i, _, _, _, _),
                .parsingSystemExclusiveMessage(let bytes, let i, _),
                .parsingDataTail(let bytes, let i, _),
                .running(let bytes, let i, _):
            
            switch i < bytes.count {
            
            case true:
                
                switch bytes[i].isStatusByte {
                
                case true:
                    return try parseStatusByte(state: state)
                
                case false:
                    return try parseDataByte(state: state)
                }
            
            case false:
                return (nil, state)
            }
        }
    }

    fileprivate func parseStatusByte(state: ARMIDIParseState) throws -> (ARMIDIMessage?, ARMIDIParseState) {
        
        switch state {
        case    .parsing(let bytes, let i),
                .parsingDataTail(let bytes, let i, _),
                .parsingData(bytes: let bytes, let i, _, _, _, _),
                .parsingSystemExclusiveMessage(let bytes, let i, _),
                .running(let bytes, let i, _):
            
            switch bytes[i] {
                
            case let b where b.isSystemRealTimeStatusByte:
                return try parseSystemRealTimeMessage(state: state)
                
            case let b where b.isSystemCommonStatusByte:
                return try parseSystemCommonMessage(state: state)
                
            case let b where b.isSystemExclusiveStatusByte:
                return try parseSystemExclusiveMessage(state: state)
                
            case let b where b.isChannelStatusByte:
                return try parseChannelMessageStatusByte(state: state)
                
            case let b:
                fatalError("Parser Error: parseStatusByte attempted to parse data byte \(b) as a status byte (state: \(state))")
            }
        }
    }

    fileprivate func parseSystemRealTimeMessage(state: ARMIDIParseState) throws -> (ARMIDIMessage, ARMIDIParseState) {
        
        func realTimeMessageForByte(_ byte: UInt8) throws -> ARMIDIMessage {
        
            switch byte {
                
            case 0xF8:          return .systemRealTimeTimingClock
            case 0xFA:          return .systemRealTimeStart
            case 0xFB:          return .systemRealTimeContinue
            case 0xFC:          return .systemRealTimeStop
            case 0xFE:          return .systemRealTimeActiveSensing
            case 0xFF:          return .systemRealTimeSystemReset
                
            case 0xF9:          throw ARMIDIParseError.undefinedSystemRealTimeStatusByte0xF9
            case 0xFD:          throw ARMIDIParseError.undefinedSystemRealTimeStatusByte0xFD
                
            default:
                fatalError("Parser Error: parseSystemRealTimeMessage was handed a non-Real Time system status byte (byte: \(byte))")
            }
        }
        
        switch state {
        case .parsing(let bytes, let i):
            return (try realTimeMessageForByte(bytes[i]), .parsing(bytes: bytes, index: i + 1))
                
        case .parsingData(let bytes, let i, let statusByte, let data, let expectedDataCount, let currentDataCount):
            return (try realTimeMessageForByte(bytes[i]), .parsingData(bytes: bytes, index: i + 1, statusByte: statusByte, data: data, expectedDataCount: expectedDataCount, currentDataCount: currentDataCount))
                
        case .parsingDataTail(let bytes, let i, let data):
            return (try realTimeMessageForByte(bytes[i]), .parsingDataTail(bytes: bytes, index: i + 1, data: data))
                
        case .parsingSystemExclusiveMessage(let bytes, let i, let data):
            return (try realTimeMessageForByte(bytes[i]), .parsingSystemExclusiveMessage(bytes: bytes, index: i + 1, data: data))
            
        case .running(let bytes, let i, let statusByte):
            return (try realTimeMessageForByte(bytes[i]), .running(bytes: bytes, index: i + 1, statusByte: statusByte))
        }
    }

    fileprivate func parseSystemCommonMessage(state: ARMIDIParseState) throws -> (ARMIDIMessage?, ARMIDIParseState) {
        
        switch state {
            
        case    .parsing(let bytes, let i):
            
            switch bytes[i] {
            
            case 0xF1:
                return try parseMIDI(state: .parsingData(bytes: bytes, index: i + 1, statusByte: 0xF1, data: Data(), expectedDataCount: 1, currentDataCount: 0))
                
            case 0xF2:
                return try parseMIDI(state: .parsingData(bytes: bytes, index: i + 1, statusByte: 0xF2, data: Data(), expectedDataCount: 2, currentDataCount: 0))
            
            case 0xF3:
                return try parseMIDI(state: .parsingData(bytes: bytes, index: i + 1, statusByte: 0xF2, data: Data(), expectedDataCount: 1, currentDataCount: 0))
                
            case 0xF4:
                throw ARMIDIParseError.undefinedSystemCommonStatusByte0xF4
                
            case 0xF5:
                throw ARMIDIParseError.undefinedSystemCommonStatusByte0xF5
                
            case 0xF6:
                return (.systemCommonTuneRequest, .parsing(bytes: bytes, index: i + 1))
                
            case 0xF7:
                return (.unassociatedDataTail(Data([0xF7])), .parsing(bytes: bytes, index: i + 1))
                
            default:
                fatalError("Parser Error: parseSystemCommonMessage was called with a non-system status byte (byte: \(bytes[i])).")
            }
            
        case .parsingSystemExclusiveMessage(let bytes, let i, var data):
            
            switch bytes[i] == 0xF7 {
                
            case true:
                data.append(0xF7)
                return (.systemExclusive(data: data), .parsing(bytes: bytes, index: i + 1))
                
            case false:
                throw ARMIDIParseError.unexpectedSystemCommonStatusByte(state: state)
            }
            
        case    .parsingDataTail(bytes: let bytes, let i, var data):
            
            switch bytes[i] == 0xF7 {
                
            case true:
                data.append(0xF7)
                return (.unassociatedDataTail(data), .parsing(bytes: bytes, index: i + 1))
                
            case false:
                return (.unassociatedDataTail(data), .parsing(bytes: bytes, index: i))
            }
            
        case    .parsingData(_, _, _, _, _, _):
            throw ARMIDIParseError.unexpectedSystemCommonStatusByte(state: state)
            
        case    .running(let bytes, let i, _):
            return try parseSystemCommonMessage(state: .parsing(bytes: bytes, index: i))
        }
    }

    fileprivate func parseSystemExclusiveMessage(state: ARMIDIParseState) throws -> (ARMIDIMessage?, ARMIDIParseState) {
        
        switch state {
            
        case    .parsing(let bytes, let i):
            return try parseMIDI(state: .parsingSystemExclusiveMessage(bytes: bytes, index: i + 1, data: Data([0xF8])))
            
        case    .parsingData(_, _, _, _, _, _),
                .parsingSystemExclusiveMessage(_, _, _):
            throw ARMIDIParseError.unexpectedSystemExclusiveStatusByte(state: state)
            
        case    .parsingDataTail(let bytes, let i, let data):
            return (.unassociatedDataTail(data), .parsing(bytes: bytes, index: i))
            
        case    .running(let bytes, let i, _):
            return try parseSystemExclusiveMessage(state: .parsing(bytes: bytes, index: i))
        }
    }

    fileprivate func parseChannelMessageStatusByte(state: ARMIDIParseState) throws -> (ARMIDIMessage?, ARMIDIParseState) {
        switch state {
        case    .parsing(let bytes, let i):
            
            switch bytes[i] >> 4 {
                
            case let b where b == 0xC || b == 0xD:
                return try parseMIDI(state: .parsingData(bytes: bytes, index: i + 1, statusByte: bytes[i], data: Data(), expectedDataCount: 1, currentDataCount: 0))
                
            case let b where b == 0x8 || b == 0x9 || b == 0xA || b == 0xB || b == 0xE:
                return try parseMIDI(state: .parsingData(bytes: bytes, index: i + 1, statusByte: bytes[i], data: Data(), expectedDataCount: 2, currentDataCount: 0))
                
            case let b:
                fatalError("Parse Error: parseChannelMessageStatusByte was handed a non-channel message status byte (byte: \(b), state: \(state)).")
            }
            
        case    .parsingDataTail(let bytes, let i, let data):
            return (.unassociatedDataTail(data), .parsing(bytes: bytes, index: i))
            
        case    .running(let bytes, let i, _):
            return try parseChannelMessageStatusByte(state: .parsing(bytes: bytes, index: i))
            
        case    .parsingData(_, _, _, _, _, _),
                .parsingSystemExclusiveMessage(_, _, _):
            throw ARMIDIParseError.unexpectedChannelStatusByte(state: state)
        }
    }


    fileprivate func parseDataByte(state: ARMIDIParseState) throws -> (ARMIDIMessage?, ARMIDIParseState) {
        
        switch state {
            
        case    .parsing(let bytes, let i):
            return try parseMIDI(state: .parsingDataTail(bytes: bytes, index: i, data: Data()))
        
        case    .parsingData(let bytes, let i, let statusByte, var data, let expectedDataCount, var currentDataCount):
            
            data.append(bytes[i])
            currentDataCount += 1
            
            switch currentDataCount < expectedDataCount {
                
            case true:
                return try parseMIDI(state: .parsingData(bytes: bytes, index: i + 1, statusByte: statusByte, data: data, expectedDataCount: expectedDataCount, currentDataCount: currentDataCount + 1))
                
            case false:
                let ch = Int(statusByte & 0x0F + 1)
                
                switch statusByte {
                    
                case let b where b >> 4 == 0x8:
                    return (.voiceNoteOff(channel: ch, note: data[0], velocity: data[1]), .parsing(bytes: bytes, index: i + 1))
                    
                case let b where b >> 4 == 0x9:
                    return (.voiceNoteOn(channel: ch, note: data[0], velocity: data[1]), .parsing(bytes: bytes, index: i + 1))
                    
                case let b where b >> 4 == 0xA:
                    return (.voicePolyphonicAftertouch(channel: ch, note: data[0], pressure: data[1]), .parsing(bytes: bytes, index: i + 1))
                    
                case let b where b >> 4 == 0xB:
                    
                    switch data[0] {
                        
                    case let b where b < 0x78:
                        return (.voiceControlChange(channel: ch, controlNumber: data[0], value: data[1]), .parsing(bytes: bytes, index: i + 1))
                        
                    case let b where b == 0x78:
                        return (.modeAllSoundOff(ch: ch), .parsing(bytes: bytes, index: i + 1))
                        
                    case let b where b == 0x79:
                        return (.modeResetAllControllers(ch: ch), .parsing(bytes: bytes, index: i + 1))
                        
                    case let b where b == 0x7A:
                        return (.modeLocalControl(ch: ch, on: data[1] == 0 ? false : true), .parsing(bytes: bytes, index: i + 1))
                        
                    case let b where b == 0x7B:
                        return (.modeAllNotesOff(ch: ch), .parsing(bytes: bytes, index: i + 1))
                        
                    case let b where b == 0x7C:
                        return (.modeOmniModeOff(ch: ch), .parsing(bytes: bytes, index: i + 1))
                        
                    case let b where b == 0x7D:
                        return (.modeOmniModeOn(ch: ch), .parsing(bytes: bytes, index: i + 1))
                        
                    case let b where b == 0x7E:
                        return (.modeMonoModeOn(ch: ch, numberOfChannels: data[1]), .parsing(bytes: bytes, index: i + 1))
                        
                    case let b where b == 0x7F:
                        return (.modePolyModeOn(ch: ch), .parsing(bytes: bytes, index: i + 1))
                        
                    case let b:
                        fatalError("Parser Error: unexpected data byte (\(String(format: "%X", b)) discovered in the data during a call to parseDataByte (state: \(state)).")
                    }
                    
                case let b where b >> 4 == 0xC:
                    return (.voiceProgramChange(channel: ch, program: data[0]), .parsing(bytes: bytes, index: i + 1))
                    
                case let b where b >> 4 == 0xD:
                    return (.voiceChannelAftertouch(channel: ch, pressure: data[0]), .parsing(bytes: bytes, index: i + 1))
                    
                case let b where b >> 4 == 0xE:
                    return (.voicePitchBendChange(ch: ch, msb: data[0], lsb: data[1]), .parsing(bytes: bytes, index: i + 1))
                    
                case let b where b == 0xF1:
                    return (.systemCommonMIDITimeCode(timeCode: data[0]), .parsing(bytes: bytes, index: i + 1))
                    
                case let b where b == 0xF2:
                    return (.systemCommonSongPosition(lsb: data[0], msb: data[1]), .parsing(bytes: bytes, index: i + 1))
                    
                case let b where b == 0xF3:
                    return (.systemCommonSongSelect(song: data[0]), .parsing(bytes: bytes, index: i + 1))
                    
                default:
                    fatalError("Parser Error: parseDataByte was handed a status byte to parse (state: \(state).")
                }
            }
            
        case    .parsingDataTail(let bytes, let i, var data):
            data.append(bytes[i])
            return try parseMIDI(state: .parsingDataTail(bytes: bytes, index: i + 1, data: data))
            
        case    .parsingSystemExclusiveMessage(let bytes, let i, var data):
            data.append(bytes[i])
            return try parseMIDI(state: .parsingSystemExclusiveMessage(bytes: bytes, index: i + 1, data: data))
            
        case    .running(let bytes, let i, let statusByte):
            
            let data = Data([bytes[i]])
            
            let ch = Int((statusByte & 0x0F) + 1)
            
            switch statusByte >> 4 {
                
            case 0xC:
                return (.voiceProgramChange(channel: ch, program: data[0]), .running(bytes: bytes, index: i + 1, statusByte: statusByte))
                
            case 0xD:
                return (.voiceChannelAftertouch(channel: ch, pressure: data[0]), .running(bytes: bytes, index: i + 1, statusByte: statusByte))
                
            case 0x8, 0x9, 0xA, 0xB, 0xE:
                return try parseMIDI(state: .parsingData(bytes: bytes, index: i + 1, statusByte: statusByte, data: data, expectedDataCount: 2, currentDataCount: 1))
            default:
                fatalError("Parser Error: parsDataByte was called in the .running state but with a non-channel message status byte (state: \(state)).")
            }
            
        }
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
