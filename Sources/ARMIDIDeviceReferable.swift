//
//  ARMIDIDeviceReferable.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/4/25.
//

import CoreMIDI

public protocol DeviceReferable: ObjectReferable {
    
    /// The number of MIDI entities in this MIDI device.
    ///
    /// - Returns: The number of MIDI entities in this MIDI device.
    func numberOfEntities() -> Int
    
    /// The MIDI entity in this MIDI device at the provided index.
    ///
    /// - Parameter index: The index of the MIDI entity to return.
    ///
    /// - Returns: The MIDI entity in this MIDI device at the provided index.
    func entity(atIndex index: Int) -> any EntityReferable
    
    /// An array of all MIDI entities in this device.
    ///
    /// - Returns: An `Array<EntityReferable>` of all MIDI entities in the MIDI device.
    func entities() -> [any EntityReferable]
}

extension DeviceReferable {
    
    public func numberOfEntities() -> Int {
        return Int(MIDIDeviceGetNumberOfEntities(self.midiRef))
    }
    
    public func entity(atIndex index: Int) -> any EntityReferable {
        return MIDIDeviceGetEntity(self.midiRef, index)
    }
    
    public func entities() -> [any EntityReferable] {
        return (0..<self.numberOfEntities()).map(self.entity)
    }
}
