//
//  ARMIDIEntity.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public class ARMIDIEntity: ARMIDIObject, ARMIDIEntityType {
    
    public override func deviceID() throws -> Int32? {
        return try super.deviceID()
    }
}

public class ARMIDIInternalEntity: ARMIDIEntity {
    public init(midiRef: MIDIEntityRef) {
        super.init(midiRef: midiRef, objectType: .entity)
    }
}

public class ARMIDIExternalEntity: ARMIDIEntity {
    public init(midiRef: MIDIEntityRef) {
        super.init(midiRef: midiRef, objectType: .externalEntity)
    }
}
