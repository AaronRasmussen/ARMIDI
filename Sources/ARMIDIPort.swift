//
//  ARMIDIPort.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/6/25.
//

import CoreMIDI
import ARMIDIError

/// Creates a MIDI input port.
///
/// - Parameters:
///   - name: The name of the MIDI input port.
///   - client: The MIDI client that registers the MIDI input port.
///   - messageHandler: A `MIDIReadBlock` for parsing the incoming MIDI packet list.
/// - Throws: `MIDIError`
/// - Returns: A `PortReferable` MIDI input port.
public func createInputPort(name: String, client: ClientReferable, messageHandler: @escaping MIDIReadBlock) throws -> PortReferable {
    
    var port: MIDIPortRef = 0
    let status = MIDIInputPortCreateWithBlock(client.midiRef, name as CFString, &port, messageHandler)
    
    guard
        status == 0
    else {
        throw MIDIError(status)
    }
    
    return port
}

extension MIDIPortRef: PortReferable { }
