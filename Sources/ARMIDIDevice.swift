//
//  ARMIDIDevice.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/3/25.
//

import CoreMIDI

/// The number of internal MIDI devices.
///
/// - Returns: The number of internal MIDI devices.
public func numberOfDevices() -> Int {
    return Int(MIDIGetNumberOfDevices())
}

/// The internal MIDI device at the provided index.
///
/// - Parameter index: The index of the internal device to return.
///
/// - Returns: The `MIDIDeviceRef` of the internal device at the provided index.
public func device(atIndex index: Int) -> MIDIDeviceRef {
    return MIDIGetDevice(index)
}

/// An array of all internal MIDI devices.
///
/// - Returns: An `Array<MIDIDeviceRef>` of all the internal MIDI devices registered with the system.
public func devices() -> [MIDIDeviceRef] {
    (0..<numberOfDevices()).map(device)
}
