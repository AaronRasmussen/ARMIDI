//
//  ARMIDIParserMessage.swift
//  
//
//  Created by Aaron Rasmussen on 10/5/24.
//

public enum ARMIDIParserMessage {
    
    case voiceNoteOff(channel: Int, note: UInt8, velocity: UInt8)
    case voiceNoteOn(channel: Int, note: UInt8, velocity: UInt8)
    case voicePolyphonicAftertouch(channel: Int, note: UInt8, pressure: UInt8)
    case voiceControlChange(channel: Int, controlNumber: UInt8, value: UInt8)
    case voiceProgramChange(channel: Int, program: UInt8)
    case voiceChannelAftertouch(channel: Int, pressure: UInt8)
    case voicePitchBendChange(ch: Int, msb: UInt8, lsb: UInt8)
    case modeAllSoundOff(ch: Int)
    case modeResetAllControllers(ch: Int)
    case modeLocalControl(ch: Int, on: Bool)
    case modeAllNotesOff(ch: Int)
    case modeOmniModeOff(ch: Int)
    case modeOmniModeOn(ch: Int)
    case modeMonoModeOn(ch: Int, numberOfChannels: UInt8)
    case modePolyModeOn(ch: Int)
    case systemExclusive(data: Data)
    case systemCommonMIDITimeCode(timeCode: UInt8)
    case systemCommonSongPosition(lsb: UInt8, msb: UInt8)
    case systemCommonSongSelect(song: UInt8)
    case systemCommonTuneRequest
    case systemCommonEOX
    case systemRealTimeTimingClock
    case systemRealTimeStart
    case systemRealTimeContinue
    case systemRealTimeStop
    case systemRealTimeActiveSensing
    case systemRealTimeSystemReset
    case unassociatedDataTail(Data)
}
