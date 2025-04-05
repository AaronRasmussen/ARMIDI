//
//  ARMIDIUInt32.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 4/5/25.
//

import CoreMIDI

extension UInt32: @retroactive Identifiable {}
extension MIDIObjectRef: ObjectReferable {
    
    public var midiRef: UInt32 {
        get {
            return self
        }
    }
}

extension MIDIDeviceRef: DeviceReferable { }
extension MIDIEntityRef: EntityReferable { }
extension MIDIEndpointRef: EndpointReferable { }
extension MIDIEndpointRef: SourceReferable { }
extension MIDIEndpointRef: DestinationReferable { }
extension MIDIClientRef: ClientReferable { }
extension MIDIPortRef: InputPortReferable { }
