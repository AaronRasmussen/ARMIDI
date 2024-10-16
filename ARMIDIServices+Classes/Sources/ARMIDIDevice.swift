//
//  ARMIDIDevice.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public class ARMIDIDevice: ARMIDIObject, ARMIDIDeviceType {
    
    public static func devices() throws -> [ARMIDIDevice] {
        return try ARMIDI.devices().map { try ARMIDIDevice(midiRef: $0) }
    }
    
    public static func externalDevices() throws -> [ARMIDIExternalDevice] {
        return try ARMIDI.externalDevices().map { try ARMIDIExternalDevice(midiRef: $0) }
    }
    
    public required convenience init(midiRef: MIDIObjectRef) throws {
        try self.init(midiRef: midiRef, objectType: .device)
    }
    
    override init(midiRef: MIDIObjectRef, objectType: MIDIObjectType) throws {
        try super.init(midiRef: midiRef, objectType: objectType)
    }
}

public class ARMIDIExternalDevice: ARMIDIDevice {
    
    public required init(midiRef: MIDIObjectRef) throws {
        try super.init(midiRef: midiRef, objectType: .externalDevice)
    }
}
