//
//  ARMIDIPort.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public class ARMIDIPort: ARMIDIPortType {
    
    public let midiRef: MIDIPortRef
    
    required public init(midiRef: MIDIPortRef) {
        self.midiRef = midiRef
    }
}
