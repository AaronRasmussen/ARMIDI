//
//  ARMIDIClientType.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public protocol ARMIDIClientType: ARMIDIObjectType {
    
    func createInputPortNamed(_ name: String, withContext context: UnsafeMutableRawPointer?, usingCallback callback: MIDIReadProc) throws -> MIDIEndpointRef
    func createInputPortNamed(_ name: String, usingBlock block: @escaping MIDIReadBlock) throws -> MIDIEndpointRef
    @available(macOS 11.0, *)
    func createInputPortNamed(_ name: String, usingProtocol midiProtocol: MIDIProtocolID, withBlock block: @escaping MIDIReceiveBlock) throws -> MIDIPortRef
    func createOutputPortNamed(_ name: String) throws -> MIDIPortRef
    func createSourceNamed(_ name: String) throws -> MIDIEndpointRef
    @available(macOS 11.0, *)
    func createSourceNamed(_ name: String, usingProtocol midiProtocol: MIDIProtocolID) throws -> MIDIEndpointRef
    func createDestinationNamed(_ name: String, withCallback callback: MIDIReadProc, context: UnsafeMutableRawPointer?) throws -> MIDIEndpointRef
    func createDestinationNamed(_ name: String, withBlock block: @escaping MIDIReadBlock) throws -> MIDIEndpointRef
    @available(macOS 11.0, *)
    func createDestinationNamed(_ name: String, usingProtocol midiProtocol: MIDIProtocolID, withBlock block: @escaping MIDIReceiveBlock) throws -> MIDIEndpointRef
}

public extension ARMIDIClientType {
    
    func createInputPortNamed(_ name: String, withContext context: UnsafeMutableRawPointer?, usingCallback callback: MIDIReadProc) throws -> MIDIEndpointRef {
        return try createInputPortForClient(self.midiRef, named: name, withContext: context, usingCallback: callback)
    }
    
    func createInputPortNamed(_ name: String, usingBlock block: @escaping MIDIReadBlock) throws -> MIDIEndpointRef {
        return try createInputPortForClient(self.midiRef, named: name, withBlock: block)
    }
    
    @available(macOS 11.0, *)
    func createInputPortNamed(_ name: String, usingProtocol midiProtocol: MIDIProtocolID, withBlock block: @escaping MIDIReceiveBlock) throws -> MIDIPortRef {
        return try createInputPortForClient(self.midiRef, named: name, usingProtocol: midiProtocol, withBlock: block)
    }
    func createOutputPortNamed(_ name: String) throws -> MIDIPortRef {
        return try createOutputPortForClient(self.midiRef, named: name)
    }
    
    func createSourceNamed(_ name: String) throws -> MIDIEndpointRef {
        return try createSourceForClient(self.midiRef, named: name)
    }
    
    @available(macOS 11.0, *)
    func createSourceNamed(_ name: String, usingProtocol midiProtocol: MIDIProtocolID) throws -> MIDIEndpointRef {
        return try createSourceForClient(self.midiRef, named: name, usingProtocol: midiProtocol)
    }
    
    func createDestinationNamed(_ name: String, withContext context: UnsafeMutableRawPointer?, withCallback callback: MIDIReadProc) throws -> MIDIEndpointRef {
        return try createDestinationForClient(self.midiRef, named: name, withContext: context, withCallback: callback)
    }
    
    func createDestinationNamed(_ name: String, withBlock block: @escaping MIDIReadBlock) throws -> MIDIEndpointRef {
        return try createDestinationForClient(self.midiRef, named: name, withBlock: block)
    }
    
    @available(macOS 11.0, *)
    func createDestinationNamed(_ name: String, usingProtocol midiProtocol: MIDIProtocolID, withBlock block: @escaping MIDIReceiveBlock) throws -> MIDIEndpointRef {
        return try createDestinationForClient(self.midiRef, named: name, usingProtocol: midiProtocol, withBlock: block)
    }
}
