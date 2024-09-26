//
//  ARMIDIDevice.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public class ARMIDIDevice: ARMIDIObject, ARMIDIDeviceType {
    
    public static func devices<T: ARMIDIDeviceType>() throws -> [T] {
        return try ARMIDI.devices().map { try T(midiRef: $0) }
    }
    
    public static func externalDevices<T: ARMIDIDeviceType>() throws -> [T] {
        return try ARMIDI.externalDevices().map { try T(midiRef: $0) }
    }
    
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
    
    public required init(midiRef: MIDIObjectRef) throws {
        try super.init(midiRef: midiRef, objectType: .device)
    }
}

public class ARMIDIExternalDevice: ARMIDIDevice {
    
    public required init(midiRef: MIDIObjectRef) throws {
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
