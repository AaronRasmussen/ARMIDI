//
//  ARMIDIPortType.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public protocol ARMIDIPortType {
    
    var midiRef: MIDIPortRef { get }
    
    init(midiRef: MIDIPortRef)
    
    func connect<T: ARMIDIEndpointType>(toSource: T, context: UnsafeMutableRawPointer?) throws
    func disconnect<T: ARMIDIEndpointType>(fromSource: T) throws
}

public extension ARMIDIPortType {
    
    func connect<T: ARMIDIEndpointType>(toSource s: T, context c: UnsafeMutableRawPointer?) throws {
        return try ARMIDI.connect(port: self.midiRef, toSource: s.midiRef, context: c)
    }
    
    func disconnect<T: ARMIDIEndpointType>(fromSource s: T) throws {
        return try ARMIDI.disconnect(port: self.midiRef, fromSource: s.midiRef)
    }
}
