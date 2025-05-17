//
//  ARMIDIUInt32.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 4/5/25.
//

import CoreMIDI

extension UInt32: ObjectReferable {
    
    /// The `MIDIObjectRef` that is used to reference this MIDI object.
    public var midiRef: MIDIObjectRef { self }
}

extension UInt32: DeviceReferable { }

extension UInt32: EntityReferable { }

extension UInt32: EndpointReferable { }

extension UInt32: SourceReferable { }

extension UInt32: DestinationReferable { }

extension UInt32: ClientReferable { }

extension UInt32: InputPortReferable { }

extension UInt32: @retroactive Identifiable { }
