//
//  ARMIDIPortType.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public protocol ARMIDIPortType {
    
    var midiRef: MIDIPortRef { get }
    
    func connectToSource(_ source: MIDIEndpointRef, withContext context: UnsafeMutableRawPointer?) throws
    func disconnectFromSource(_ source: MIDIEndpointRef) throws
}

public extension ARMIDIPortType {
    
    func connectToSource(_ source: MIDIEndpointRef, withContext context: UnsafeMutableRawPointer?) throws {
        return try connectPort(self.midiRef, toSource: source, withContext: context)
    }
    
    func disconnectFromSource(_ source: MIDIEndpointRef) throws {
        return try disconnectPort(self.midiRef, fromSource: source)
    }
}
