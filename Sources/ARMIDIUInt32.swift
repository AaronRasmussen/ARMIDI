//
//  ARMIDIUInt32.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 4/5/25.
//

extension UInt32: ObjectReferable {
    
    public var midiRef: UInt32 {
        get {
            return self
        }
    }
}

extension UInt32: DeviceReferable { }

extension UInt32: EntityReferable { }

extension UInt32: EndpointReferable { }

extension UInt32: SourceReferable { }

extension UInt32: DestinationReferable { }

extension UInt32: ClientReferable { }

extension UInt32: InputPortReferable { }

extension UInt32: @retroactive Identifiable { }
