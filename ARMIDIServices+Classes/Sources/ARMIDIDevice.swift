//
//  ARMIDIDevice.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public class ARMIDIDevice: ARMIDIObject, ARMIDIDeviceType { }

public class ARMIDIInternalDevice: ARMIDIDevice {
    public init(midiRef: MIDIObjectRef) {
        super.init(midiRef: midiRef, objectType: .device)
    }
}

public class ARMIDIExternalDevice: ARMIDIDevice {
    public init(midiRef: MIDIObjectRef) {
        super.init(midiRef: midiRef, objectType: .externalDevice)
    }
}
