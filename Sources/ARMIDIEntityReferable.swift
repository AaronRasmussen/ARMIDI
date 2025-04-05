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
    /// - Returns: A `MIDIDeviceRef` for this MIDI entity's parent MIDI device.
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
    func source(atIndex index: Int) -> SourceReferable
    
    /// The MIDI destination in this MIDI entity at the provided index.
    ///
    /// - Parameter index: The index of the MIDI destination to return.
    ///
    /// - Returns: The `MIDIEndpointRef` of the MIDI destination in this MIDI entity at the provided index.
    func destination(atIndex index: Int) -> DestinationReferable
    
    /// An array of all MIDI sources in this MIDI entity.
    ///
    /// - Returns: An `Array<MIDIEndpointRef>` of all MIDI sources in this MIDI entity.
    func sources() -> [SourceReferable]
    
    /// An array of MIDI destinations in this MIDI entity.
    ///
    /// - Returns: An `Array<MIDIEndpointRef>` of all MIDI destinations in this MIDI entity.
    func destinations() -> [DestinationReferable]
}

extension EntityReferable {
    
    public func device() throws -> DeviceReferable {
        
        var device: MIDIDeviceRef = 0
        let status = MIDIEntityGetDevice(self.midiRef, &device)
        
        guard
            status == 0
        else {
            throw MIDIError(status)
        }
        
        return device
    }
    
    public func numberOfSources() -> Int {
        return MIDIEntityGetNumberOfSources(self.midiRef) as Int
    }
    
    public func numberOfDestinations() -> Int {
        return MIDIEntityGetNumberOfDestinations(self.midiRef) as Int
    }
    
    public func source(atIndex index: Int) -> SourceReferable {
        return MIDIEntityGetSource(self.midiRef, index)
    }
    
    public func destination(atIndex index: Int) -> DestinationReferable {
        return MIDIEntityGetDestination(self.midiRef, index)
    }
    
    public func sources() -> [SourceReferable] {
        return (0..<self.numberOfSources()).map(self.source)
    }
    
    public func destinations() -> [DestinationReferable] {
        return (0..<self.numberOfDestinations()).map(self.destination)
    }
}
