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
    
    func connectToSource<T: ARMIDIEndpointType>(_ source: T, withContext context: UnsafeMutableRawPointer?) throws
    func disconnectFromSource<T: ARMIDIEndpointType>(_ source: T) throws
}

public extension ARMIDIPortType {
    
    func connectToSource<T: ARMIDIEndpointType>(_ source: T, withContext context: UnsafeMutableRawPointer?) throws {
        return try connectPort(self.midiRef, toSource: source.midiRef, withContext: context)
    }
    
    func disconnectFromSource<T: ARMIDIEndpointType>(_ source: T) throws {
        return try disconnectPort(self.midiRef, fromSource: source.midiRef)
    }
}
