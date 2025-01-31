//
//  ARMIDIServices+EventList.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

@available(macOS 11.0, *)
public func initializeEventList(_ eventList: inout MIDIEventList, usingProtocol midiProtocol: MIDIProtocolID) -> UnsafeMutablePointer<MIDIEventPacket> {
    return MIDIEventListInit(&eventList, midiProtocol)
}

@available(macOS 11.0, *)
public func addToEventList(_ eventList: inout MIDIEventList, listSize: Int, currentPacket: inout MIDIEventPacket, time: MIDITimeStamp, wordCount: Int, words: [UInt32]) -> UnsafeMutablePointer<MIDIEventPacket> {
    return MIDIEventListAdd(&eventList, listSize, &currentPacket, time, wordCount, words)
}

@available(macOS 11.0, *)
public func sendEventList(_ eventList: inout MIDIEventList, fromPort port: MIDIPortRef, toDestination destination: MIDIEndpointRef) throws {
    let status = MIDISendEventList(port, destination, &eventList)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

@available(macOS 11.0, *)
public func distributeEventList(_ eventList: inout MIDIEventList, fromSource source: MIDIEndpointRef) throws {
    let status = MIDIReceivedEventList(source, &eventList)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func nextEventPacket(currentPacket: inout MIDIEventPacket) -> UnsafeMutablePointer<MIDIEventPacket> {
    return MIDIEventPacketNext(&currentPacket)
}

