//
//  ARMIDIParserType.swift
//  Pods
//
//  Created by Aaron Rasmussen on 10/7/24.
//

public protocol ARMIDIParserType {
    
    var currentState: ARMIDIParserState? { get set }
    
    func process(midiMessage: ARMIDIParserMessage)
}

extension ARMIDIParserType {
    
    public mutating func handle(bytes: [UInt8]) throws {
        
        var s0 = self.currentState?.addBytes(bytes) ?? ARMIDIParserState().addBytes(bytes)
        
        while s0.hasBytesLeft {
            
            let (m, s1) = try parseMIDI(state: s0)
            
            if let m = m {
                self.process(midiMessage: m)
            }
            s0 = s1
        }
        
        switch s0 {
        case .parsing(_, _):
            self.currentState = nil
        default:
            self.currentState = s0
        }
    }
    
    fileprivate func parseMIDI(state: ARMIDIParserState) throws -> (ARMIDIParserMessage?, ARMIDIParserState) {
        
        switch state {
        case    .parsing(let bs, let i),
                .parsingData(bytes: let bs, let i, _, _, _, _),
                .parsingSystemExclusiveMessage(let bs, let i, _),
                .parsingDataTail(let bs, let i, _),
                .running(let bs, let i, _):
            
            switch i < bs.count {
            
            case true:
                
                switch bs[i].isStatusByte {
                
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

    fileprivate func parseStatusByte(state: ARMIDIParserState) throws -> (ARMIDIParserMessage?, ARMIDIParserState) {
        
        switch state {
        case    .parsing(let bs, let i),
                .parsingDataTail(let bs, let i, _),
                .parsingData(bytes: let bs, let i, _, _, _, _),
                .parsingSystemExclusiveMessage(let bs, let i, _),
                .running(let bs, let i, _):
            
            switch bs[i] {
                
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

    fileprivate func parseSystemRealTimeMessage(state: ARMIDIParserState) throws -> (ARMIDIParserMessage, ARMIDIParserState) {
        
        func realTimeMessageForByte(_ byte: UInt8) throws -> ARMIDIParserMessage {
        
            switch byte {
                
            case kStatusByteSystemRealTimeTimingClock:    return .systemRealTimeTimingClock
            case kStatusByteSystemRealTimeStart:          return .systemRealTimeStart
            case kStatusByteSystemRealTimeContinue:       return .systemRealTimeContinue
            case kStatusByteSystemRealTimeStop:           return .systemRealTimeStop
            case kStatusByteSystemRealTimeActiveSensing:  return .systemRealTimeActiveSensing
            case kStatusByteSystemRealTimeSystemReset:    return .systemRealTimeSystemReset
                
            case kStatusByteSystemRealTimeUndefined_0xF9: throw ARMIDIParserError.undefinedSystemRealTimeStatusByte0xF9
            case kStatusByteSystemRealTimeUndefined_0xFD: throw ARMIDIParserError.undefinedSystemRealTimeStatusByte0xFD
                
            default:
                fatalError("Parser Error: parseSystemRealTimeMessage was handed a non-Real Time system status byte (byte: \(byte))")
            }
        }
        
        switch state {
        case .parsing(let bs, let i):
            return (try realTimeMessageForByte(bs[i]), .parsing(bytes: bs, index: i + 1))
                
        case .parsingData(let bs, let i, let sB, let d, let eDC, let cDC):
            return (try realTimeMessageForByte(bs[i]), .parsingData(bytes: bs, index: i + 1, statusByte: sB, data: d, expectedDataCount: eDC, currentDataCount: cDC))
                
        case .parsingDataTail(let bs, let i, let d):
            return (try realTimeMessageForByte(bs[i]), .parsingDataTail(bytes: bs, index: i + 1, data: d))
                
        case .parsingSystemExclusiveMessage(let bs, let i, let d):
            return (try realTimeMessageForByte(bs[i]), .parsingSystemExclusiveMessage(bytes: bs, index: i + 1, data: d))
            
        case .running(let bs, let i, let sB):
            return (try realTimeMessageForByte(bs[i]), .running(bytes: bs, index: i + 1, statusByte: sB))
        }
    }

    fileprivate func parseSystemCommonMessage(state: ARMIDIParserState) throws -> (ARMIDIParserMessage?, ARMIDIParserState) {
        
        switch state {
            
        case .parsing(let bs, let i):
            
            switch bs[i] {
            
            case kStatusByteSystemCommonMIDITimeCode:
                return try parseMIDI(state: .parsingData(bytes: bs, index: i + 1, statusByte: kStatusByteSystemCommonMIDITimeCode, data: Data(), expectedDataCount: 1, currentDataCount: 0))
                
            case kStatusByteSystemCommonSongPosition:
                return try parseMIDI(state: .parsingData(bytes: bs, index: i + 1, statusByte: kStatusByteSystemCommonSongPosition, data: Data(), expectedDataCount: 2, currentDataCount: 0))
            
            case kStatusByteSystemCommonSongSelect:
                return try parseMIDI(state: .parsingData(bytes: bs, index: i + 1, statusByte: kStatusByteSystemCommonSongSelect, data: Data(), expectedDataCount: 1, currentDataCount: 0))
                
            case kStatusByteSystemCommonUndefined_0xF4:
                throw ARMIDIParserError.undefinedSystemCommonStatusByte0xF4
                
            case kStatusByteSystemCommonUndefined_0xF5:
                throw ARMIDIParserError.undefinedSystemCommonStatusByte0xF5
                
            case kStatusByteSystemCommonTuneRequest:
                return (.systemCommonTuneRequest, .parsing(bytes: bs, index: i + 1))
                
            case kStatusByteSystemCommonEOX:
                return (.unassociatedDataTail(Data([kStatusByteSystemCommonEOX])), .parsing(bytes: bs, index: i + 1))
                
            default:
                fatalError("Parser Error: parseSystemCommonMessage was called with a non-system common status byte (byte: \(bs[i])).")
            }
            
        case    .parsingSystemExclusiveMessage(let bs, let i, var d):
            switch bs[i] == kStatusByteSystemCommonEOX {
            
            case true:
                d.append(bs[i])
                return (.systemExclusive(data: d), .parsing(bytes: bs, index: i + 1))
                
            case false:
                throw ARMIDIParserError.unexpectedSystemCommonStatusByte(state: state)
            }
            
        case    .parsingData(_, _, _, _, _, _):
            throw ARMIDIParserError.unexpectedSystemCommonStatusByte(state: state)
            
        case .parsingDataTail(bytes: let bs, let i, let d):
            return (.unassociatedDataTail(d), .parsing(bytes: bs, index: i))
            
        case .running(let bs, let i, _):
            return try parseSystemCommonMessage(state: .parsing(bytes: bs, index: i))
        }
    }

    fileprivate func parseSystemExclusiveMessage(state: ARMIDIParserState) throws -> (ARMIDIParserMessage?, ARMIDIParserState) {
        
        switch state {
            
        case .parsing(let bs, let i):
            return try parseMIDI(state: .parsingSystemExclusiveMessage(bytes: bs, index: i + 1, data: Data([bs[i]])))
            
        case    .parsingData(_, _, _, _, _, _),
                .parsingSystemExclusiveMessage(_, _, _):
            throw ARMIDIParserError.unexpectedSystemExclusiveStatusByte(state: state)
            
        case .parsingDataTail(let bs, let i, let d):
            return (.unassociatedDataTail(d), .parsingSystemExclusiveMessage(bytes: bs, index: i + 1, data: Data([bs[i]])))
            
        case .running(let bs, let i, _):
            return try parseMIDI(state: .parsingSystemExclusiveMessage(bytes: bs, index: i + 1, data: Data([bs[i]])))
        }
    }

    fileprivate func parseChannelMessageStatusByte(state: ARMIDIParserState) throws -> (ARMIDIParserMessage?, ARMIDIParserState) {
        switch state {
        case    .parsing(let bs, let i):
            
            switch bs[i].channelMessageStatusBits {
                
            case    kStatusByteProgramChange,
                    kStatusByteChannelAftertouch:
                return try parseMIDI(state: .parsingData(bytes: bs, index: i + 1, statusByte: bs[i], data: Data(), expectedDataCount: 1, currentDataCount: 0))
                
            case    kStatusByteNoteOff,
                    kStatusByteNoteOn,
                    kStatusBytePolyphonicAftertouch,
                    kStatusByteControlChangeOrMode,
                    kStatusBytePitchBendChange:
                return try parseMIDI(state: .parsingData(bytes: bs, index: i + 1, statusByte: bs[i], data: Data(), expectedDataCount: 2, currentDataCount: 0))
                
            case let b:
                fatalError("Parse Error: parseChannelMessageStatusByte was handed a non-channel message status byte (byte: \(b), state: \(state)).")
            }
            
        case    .parsingDataTail(let bs, let i, let d):
            return (.unassociatedDataTail(d), .parsing(bytes: bs, index: i))
            
        case    .running(let bs, let i, _):
            return try parseChannelMessageStatusByte(state: .parsing(bytes: bs, index: i))
            
        case    .parsingData(_, _, _, _, _, _),
                .parsingSystemExclusiveMessage(_, _, _):
            throw ARMIDIParserError.unexpectedChannelStatusByte(state: state)
        }
    }


    fileprivate func parseDataByte(state: ARMIDIParserState) throws -> (ARMIDIParserMessage?, ARMIDIParserState) {
        
        switch state {
            
        case    .parsing(let bs, let i):
            return try parseMIDI(state: .parsingDataTail(bytes: bs, index: i, data: Data()))
        
        case    .parsingData(let bs, let i, let sB, var d, let eDC, var cDC):
            
            d.append(bs[i])
            cDC += 1
            
            switch cDC < eDC {
                
            case true:
                return try parseMIDI(state: .parsingData(bytes: bs, index: i + 1, statusByte: sB, data: d, expectedDataCount: eDC, currentDataCount: cDC + 1))
                
            case false:
                let ch = sB.channel
                
                switch sB.channelMessageStatusBits {
                    
                case kStatusByteNoteOff:
                    return (.voiceNoteOff(channel: ch, note: d[0], velocity: d[1]), .parsing(bytes: bs, index: i + 1))
                    
                case kStatusByteNoteOn:
                    return (.voiceNoteOn(channel: ch, note: d[0], velocity: d[1]), .parsing(bytes: bs, index: i + 1))
                    
                case kStatusBytePolyphonicAftertouch:
                    return (.voicePolyphonicAftertouch(channel: ch, note: d[0], pressure: d[1]), .parsing(bytes: bs, index: i + 1))
                    
                case kStatusByteControlChangeOrMode:
                    
                    switch d[0] {
                        
                    case let b where b < kDataByteModeAllSoundsOff:
                        return (.voiceControlChange(channel: ch, controlNumber: d[0], value: d[1]), .parsing(bytes: bs, index: i + 1))
                        
                    case kDataByteModeAllSoundsOff:
                        return (.modeAllSoundOff(ch: ch), .parsing(bytes: bs, index: i + 1))
                        
                    case kDataByteModeResetAllControllers:
                        return (.modeResetAllControllers(ch: ch), .parsing(bytes: bs, index: i + 1))
                        
                    case kDataByteModeLocalControl:
                        return (.modeLocalControl(ch: ch, on: d[1] == 0 ? false : true), .parsing(bytes: bs, index: i + 1))
                        
                    case kDataByteModeAllNotesOff:
                        return (.modeAllNotesOff(ch: ch), .parsing(bytes: bs, index: i + 1))
                        
                    case kDataByteModeOmniModeOff:
                        return (.modeOmniModeOff(ch: ch), .parsing(bytes: bs, index: i + 1))
                        
                    case kDataByteModeOmniModeOn:
                        return (.modeOmniModeOn(ch: ch), .parsing(bytes: bs, index: i + 1))
                        
                    case kDataByteModeMonoModeOn:
                        return (.modeMonoModeOn(ch: ch, numberOfChannels: d[1]), .parsing(bytes: bs, index: i + 1))
                        
                    case kDataByteModePolyModeOn:
                        return (.modePolyModeOn(ch: ch), .parsing(bytes: bs, index: i + 1))
                        
                    case let b:
                        fatalError("Parser Error: unexpected data byte (\(String(format: "%X", b)) discovered in the data during a call to parseDataByte (state: \(state)).")
                    }
                    
                case kStatusByteProgramChange:
                    return (.voiceProgramChange(channel: ch, program: d[0]), .parsing(bytes: bs, index: i + 1))
                    
                case kStatusByteChannelAftertouch:
                    return (.voiceChannelAftertouch(channel: ch, pressure: d[0]), .parsing(bytes: bs, index: i + 1))
                    
                case kStatusBytePitchBendChange:
                    return (.voicePitchBendChange(ch: ch, msb: d[0], lsb: d[1]), .parsing(bytes: bs, index: i + 1))
                    
                case kStatusByteSystemCommonMIDITimeCode:
                    return (.systemCommonMIDITimeCode(timeCode: d[0]), .parsing(bytes: bs, index: i + 1))
                    
                case kStatusByteSystemCommonSongPosition:
                    return (.systemCommonSongPosition(lsb: d[0], msb: d[1]), .parsing(bytes: bs, index: i + 1))
                    
                case kStatusByteSystemCommonSongSelect:
                    return (.systemCommonSongSelect(song: d[0]), .parsing(bytes: bs, index: i + 1))
                    
                default:
                    fatalError("Parser Error: parseDataByte was handed a status byte to parse (state: \(state).")
                }
            }
            
        case    .parsingDataTail(let bs, let i, var d):
            d.append(bs[i])
            return try parseMIDI(state: .parsingDataTail(bytes: bs, index: i + 1, data: d))
            
        case    .parsingSystemExclusiveMessage(let bs, let i, var d):
            d.append(bs[i])
            return try parseMIDI(state: .parsingSystemExclusiveMessage(bytes: bs, index: i + 1, data: d))
            
        case    .running(let bs, let i, let sB):
            
            let d = Data([bs[i]])
            
            let ch = sB.channel
            
            switch sB.channelMessageStatusBits {
                
            case    kStatusByteProgramChange:
                return (.voiceProgramChange(channel: ch, program: d[0]), .running(bytes: bs, index: i + 1, statusByte: sB))
                
            case    kStatusByteChannelAftertouch:
                return (.voiceChannelAftertouch(channel: ch, pressure: d[0]), .running(bytes: bs, index: i + 1, statusByte: sB))
                
            case    kStatusByteNoteOff,
                    kStatusByteNoteOn,
                    kStatusBytePolyphonicAftertouch,
                    kStatusByteControlChangeOrMode,
                    kStatusBytePitchBendChange:
                return try parseMIDI(state: .parsingData(bytes: bs, index: i + 1, statusByte: sB, data: d, expectedDataCount: 2, currentDataCount: 1))
            default:
                fatalError("Parser Error: parsDataByte was called in the .running state but with a non-channel message status byte (state: \(state)).")
            }
        }
    }
}
