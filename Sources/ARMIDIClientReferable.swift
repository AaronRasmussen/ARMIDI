//
//  ARMIDIClientReferable.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/6/25.
//

import CoreMIDI
import ARMIDIError

public protocol ClientReferable: ObjectReferable {
    
    /// Creates a MIDI input port.
    ///
    /// - Parameters:
    ///   - name: The name of the MIDI input port.
    ///   - messageHandler: A `MIDIReadBlock` for parsing the incoming MIDI packet list.
    /// - Throws: `MIDIError`
    /// - Returns: A `PortReferable` MIDI input port.
    func createInputPort(name: String, messageHandler: @escaping MIDIReadBlock) throws -> any InputPortReferable
}

extension ClientReferable {
    
    public func createInputPort(name: String, messageHandler: @escaping MIDIReadBlock) throws -> any InputPortReferable {
        
        var inputPort: MIDIPortRef = 0
        
        let status = MIDIInputPortCreateWithBlock(
            self.midiRef,
            name as CFString,
            &inputPort,
            messageHandler)
        
        guard
            status == 0
        else {
            throw MIDIError(status)
        }
        
        return inputPort
    }
}
