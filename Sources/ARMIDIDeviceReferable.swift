//
//  ARMIDIDeviceReferable.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/4/25.
//

import CoreMIDI

public protocol DeviceReferable: ObjectReferable {
    
    /// The number of MIDI entities for the MIDI device.
    ///
    /// - Returns: The number of MIDI entities for the MIDI device.
    func numberOfEntities() -> Int
    
    /// The MIDI entity at the provided index.
    ///
    /// - Parameter index: The index of the entity to return.
    ///
    /// - Returns: The `MIDIEntityRef` of the MIDI entity at the provided index.
    func entity(atIndex index: Int) -> MIDIEntityRef
    
    /// An array of the MIDI entities for this device..
    ///
    /// - Returns: An `Array<MIDIEntityRef>` of all the MIDI entities for this device..
    func entities() -> [MIDIEntityRef]
}
