//
//  ARMIDIObject.swift
//  
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public class ARMIDIObject: ARMIDIObjectType {
    
    public let midiRef: MIDIObjectRef
    
    public init(midiRef: MIDIObjectRef) {
        self.midiRef = midiRef
    }
}
