//
//  ARMIDIEntityReferable.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/4/25.
//

import CoreMIDI
import ARMIDIError

public protocol EntityReferable: ObjectReferable {
    
    /// The MIDI entity's parent MIDI device.
    ///
    /// - Throws: `MIDIError`
    ///
    /// - Returns: A `MIDIDeviceRef` for the MIDI entity's parent MIDI device.
    func device() throws -> DeviceReferable
    
    /// The number of MIDI sources in this MIDI entity.
    ///
    /// - Returns: The number of MIDI sources in this MIDI entity.
    func numberOfSources() -> Int
    
    /// The number of MIDI destinations in this MIDI entity.
    ///
    /// - Returns: The number of MIDI destinations in this MIDI entity.
    func numberOfDestinations() -> Int
    
    /// The MIDI source in this MIDI entity at the provided index.
    ///
    /// - Parameter index: The index of the MIDI source to return.
    ///
    /// - Returns: The `MIDIEndpointRef` of the MIDI source in the MIDI entity at the provided index.
    func source(atIndex index: Int) -> MIDIEndpointRef
    
    /// The MIDI destination in this MIDI entity at the provided index.
    ///
    /// - Parameter index: The index of the MIDI destination to return.
    ///
    /// - Returns: The `MIDIEndpointRef` of the MIDI destination in this MIDI entity at the provided index.
    func destination(atIndex index: Int) -> MIDIEndpointRef
    
    /// An array of all MIDI sources in this MIDI entity.
    ///
    /// - Returns: An `Array<MIDIEndpointRef>` of all MIDI sources in this MIDI entity.
    func sources() -> [MIDIEndpointRef]
    
    /// An array of MIDI destinations in this MIDI entity.
    ///
    /// - Returns: An `Array<MIDIEndpointRef>` of all MIDI destinations in this MIDI entity.
    func destinations() -> [MIDIEndpointRef]
}
