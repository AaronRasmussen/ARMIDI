//
//  ARMIDIClientType.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public protocol ARMIDIClientType: ARMIDIObjectType {
    
    var midiRef: MIDIClientRef { get }
    
    func createInputPort<T: ARMIDIPortType>(name: String, context: UnsafeMutableRawPointer?, callback: @escaping MIDIReadProc) throws -> T
    func createInputPort<T: ARMIDIPortType>(name: String, block: @escaping MIDIReadBlock) throws -> T
    @available(macOS 11.0, *)
    func createInputPort<T: ARMIDIPortType>(name: String, midiProtocol: MIDIProtocolID, block: @escaping MIDIReceiveBlock) throws -> T
    func createOutputPort<T: ARMIDIPortType>(name: String) throws -> T
    func createVirtualSource<T: ARMIDIEndpointType>(name: String) throws -> T
    @available(macOS 11.0, *)
    func createVirtualSource<T: ARMIDIEndpointType>(name: String, midiProtocol: MIDIProtocolID) throws -> T
    func createVirtualDestination<T: ARMIDIEndpointType>(name: String, context: UnsafeMutableRawPointer?, callback: @escaping MIDIReadProc) throws -> T
    func createVirtualDestination<T: ARMIDIEndpointType>(name: String, block: @escaping MIDIReadBlock) throws -> T
    @available(macOS 11.0, *)
    func createVirtualDestination<T: ARMIDIEndpointType>(name: String, midiProtocol: MIDIProtocolID, block: @escaping MIDIReceiveBlock) throws -> T
}

public extension ARMIDIClientType {
    
    func createInputPort<T: ARMIDIPortType>(name n: String, context c: UnsafeMutableRawPointer?, callback cb: @escaping MIDIReadProc) throws -> T {
        return T(midiRef: try ARMIDI.createInputPort(client: self.midiRef, name: n, context: c, callback: cb))
    }
    
    func createInputPort<T: ARMIDIPortType>(name n: String, block b: @escaping MIDIReadBlock) throws -> T {
        return T(midiRef: try ARMIDI.createInputPort(client: self.midiRef, name: n, block: b))
    }
    
    @available(macOS 11.0, *)
    func createInputPort<T: ARMIDIPortType>(name n: String, midiProtocol p: MIDIProtocolID, block b: @escaping MIDIReceiveBlock) throws -> T {
        return T(midiRef: try ARMIDI.createInputPort(client: self.midiRef, name: n, midiProtocol: p, block: b))
    }
    
    func createOutputPort<T: ARMIDIPortType>(name n: String) throws -> T {
        return T(midiRef: try ARMIDI.createOutputPort(client: self.midiRef, name: n))
    }
    
    func createVirtualSource<T: ARMIDIEndpointType>(name n: String) throws -> T {
        return try T(midiRef: ARMIDI.createVirtualSource(client: self.midiRef, name: n))
    }
    
    @available(macOS 11.0, *)
    func createVirtualSource<T: ARMIDIEndpointType>(name n: String, midiProtocol p: MIDIProtocolID) throws -> T {
        return try T(midiRef: try ARMIDI.createVirtualSource(client: self.midiRef, name: n, midiProtocol: p))
    }
    
    func createVirtualDestination<T: ARMIDIEndpointType>(name n: String, context c: UnsafeMutableRawPointer?, callback cb: @escaping MIDIReadProc) throws -> T {
        return try T(midiRef: try ARMIDI.createVirtualDestination(client: self.midiRef, name: n, context: c, callback: cb))
    }
    
    func createVirtualDestination<T: ARMIDIEndpointType>(name n: String, block b: @escaping MIDIReadBlock) throws -> T {
        return try T(midiRef: try ARMIDI.createVirtualDestination(client: self.midiRef, name: n, block: b))
    }
    
    @available(macOS 11.0, *)
    func createVirtualDestination<T: ARMIDIEndpointType>(name n: String, midiProtocol p: MIDIProtocolID, block b: @escaping MIDIReceiveBlock) throws -> T {
        return try T(midiRef: ARMIDI.createVirtualDestination(client: self.midiRef, name: n, midiProtocol: p, block: b))
    }
}
