//
//  ARMIDIClient.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public class ARMIDIClient: ARMIDIClientType {
    
    public let midiRef: MIDIClientRef
    
    public init(midiRef: MIDIClientRef) {
        self.midiRef = midiRef
    }
}
