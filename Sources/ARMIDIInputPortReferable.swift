//
//  ARMIDIPortReferable.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/6/25.
//

import CoreMIDI
import ARMIDIError

public protocol InputPortReferable: ObjectReferable {
    
    /// Connects this MIDI input port to the given MIDI source.
    ///
    /// - Parameter source: The MIDI source to connect to the MIDI input port.
    /// - Throws: `MIDIError`
    func connect(toSource source: SourceReferable) throws
}

extension InputPortReferable {
    
    public func connect(toSource source: any SourceReferable) throws {
        
        let status = MIDIPortConnectSource(self.midiRef, source.midiRef, nil)
        
        guard
            status == 0
        else {
            throw MIDIError(status)
        }
    }
}
