//
//  ARMIDIServices+Ports.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public func connectPort(_ port: MIDIPortRef, toSource source: MIDIEndpointRef, withContext context: UnsafeMutableRawPointer?) throws {
    let status = MIDIPortConnectSource(port, source, context)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func disconnectPort(_ port: MIDIPortRef, fromSource source: MIDIEndpointRef) throws {
    let status = MIDIPortDisconnectSource(port, source)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func disposeOfPort(_ portRef: MIDIPortRef) throws {
    let status = MIDIPortDispose(portRef)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}
