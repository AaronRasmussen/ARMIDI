//
//  ARMIDIDevice.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public class ARMIDIDevice: ARMIDIObject, ARMIDIDeviceType {
    
    public override func model() throws -> String? {
        return try super.model()
    }
    
    public override func manufacturer() throws -> String? {
        return try super.manufacturer()
    }
    
    public override func deviceID() throws -> Int32? {
        return try super.deviceID()
    }
}

public class ARMIDIInternalDevice: ARMIDIDevice {
    
    public init(midiRef: MIDIObjectRef) throws {
        try super.init(midiRef: midiRef, objectType: .device)
    }
}

public class ARMIDIExternalDevice: ARMIDIDevice {
    
    public init(midiRef: MIDIObjectRef) throws {
        try super.init(midiRef: midiRef, objectType: .externalDevice)
    }
    
    public override func model(newValue value: String) throws {
        return try super.model(newValue: value)
    }
    
    public override func manufacturer(newValue value: String) throws {
        return try super.manufacturer(newValue: value)
    }
    
    public override func deviceID(newValue value: Int32) throws {
        return try super.deviceID(newValue: value)
    }
}
