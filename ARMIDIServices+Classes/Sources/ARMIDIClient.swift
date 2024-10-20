//
//  ARMIDIClient.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public class ARMIDIClient: ARMIDIClientType {
    
    public let midiRef: MIDIClientRef
    
    internal init(midiRef: MIDIClientRef) {
        self.midiRef = midiRef
    }
    
    public static func createClient(name n: String, context c: UnsafeMutableRawPointer?, callback cb: MIDINotifyProc?) throws -> ARMIDIClient {
        return ARMIDIClient(midiRef: try ARMIDI.createClient(name: n, context: c, callback: cb))
    }
    
    public static func createClient(name n: String, block b: MIDINotifyBlock?) throws -> ARMIDIClient {
        return ARMIDIClient(midiRef: try ARMIDI.createClient(name: n, block: b))
    }
    
    public func name() throws -> String? {
        return try ARMIDI.getStringProperty(forObject: self.midiRef, property: kMIDIPropertyName)
    }
}
