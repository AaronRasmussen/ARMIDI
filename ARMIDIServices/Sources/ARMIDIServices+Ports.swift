//
//  ARMIDIServices+Ports.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public func connect(port p: MIDIPortRef, toSource s: MIDIEndpointRef, withContext c: UnsafeMutableRawPointer?) throws {
    let status = MIDIPortConnectSource(p, s, c)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func disconnect(port p: MIDIPortRef, fromSource s: MIDIEndpointRef) throws {
    let status = MIDIPortDisconnectSource(p, s)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func dispose(ofPort p: MIDIPortRef) throws {
    let status = MIDIPortDispose(p)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}
