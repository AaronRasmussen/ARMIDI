//
//  ARMIDIServices+PacketList.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public func initializePacketList(_ packetList: inout MIDIPacketList) -> UnsafeMutablePointer<MIDIPacket> {
    return MIDIPacketListInit(&packetList)
}

public func addToPacketList(_ packetList: inout MIDIPacketList, listSize: Int, currentPacket: inout MIDIPacket, time: MIDITimeStamp, dataCount: Int, data: [UInt8]) -> UnsafeMutablePointer<MIDIPacket> {
    return MIDIPacketListAdd(&packetList, listSize, &currentPacket, time, dataCount, data)
}

public func sendPacketList(_ packetList: inout MIDIPacketList, fromPort port: MIDIPortRef, toDestination destination: MIDIEndpointRef) throws {
    let status = MIDISend(port, destination, &packetList)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func distributePacketList(_ packetList: inout MIDIPacketList, fromSource source: MIDIEndpointRef) throws {
    let status = MIDIReceived(source, &packetList)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func nextPacket(_ currentPacket: inout MIDIPacket) -> UnsafeMutablePointer<MIDIPacket> {
    return MIDIPacketNext(&currentPacket)
}
