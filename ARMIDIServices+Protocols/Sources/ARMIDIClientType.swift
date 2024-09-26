//
//  ARMIDIClientType.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public protocol ARMIDIClientType {
    
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
    
    func createInputPort<T: ARMIDIPortType>(name: String, context: UnsafeMutableRawPointer?, callback: @escaping MIDIReadProc) throws -> T {
        return T(midiRef: try ARMIDI.createInputPort(client: self.midiRef, name: name, context: context, callback: callback))
    }
    
    func createInputPort<T: ARMIDIPortType>(name: String, block: @escaping MIDIReadBlock) throws -> T {
        return T(midiRef: try ARMIDI.createInputPort(client: self.midiRef, name: name, block: block))
    }
    
    @available(macOS 11.0, *)
    func createInputPort<T: ARMIDIPortType>(name: String, midiProtocol: MIDIProtocolID, block: @escaping MIDIReceiveBlock) throws -> T {
        return T(midiRef: try ARMIDI.createInputPort(client: self.midiRef, name: name, midiProtocol: midiProtocol, block: block))
    }
    
    func createOutputPort<T: ARMIDIPortType>(name: String) throws -> T {
        return T(midiRef: try ARMIDI.createOutputPort(client: self.midiRef, name: name))
    }
    
    func createVirtualSource<T: ARMIDIEndpointType>(name: String) throws -> T {
        return try T(midiRef: ARMIDI.createVirtualSource(client: self.midiRef, name: name))
    }
    
    @available(macOS 11.0, *)
    func createVirtualSource<T: ARMIDIEndpointType>(name: String, midiProtocol: MIDIProtocolID) throws -> T {
        return try T(midiRef: try ARMIDI.createVirtualSource(client: self.midiRef, name: name, midiProtocol: midiProtocol))
    }
    
    func createVirtualDestination<T: ARMIDIEndpointType>(name: String, context: UnsafeMutableRawPointer?, callback: @escaping MIDIReadProc) throws -> T {
        return try T(midiRef: try ARMIDI.createVirtualDestination(client: self.midiRef, name: name, context: context, callback: callback))
    }
    
    func createVirtualDestination<T: ARMIDIEndpointType>(name: String, block: @escaping MIDIReadBlock) throws -> T {
        return try T(midiRef: try ARMIDI.createVirtualDestination(client: self.midiRef, name: name, block: block))
    }
    
    @available(macOS 11.0, *)
    func createVirtualDestination<T: ARMIDIEndpointType>(name: String, midiProtocol: MIDIProtocolID, block: @escaping MIDIReceiveBlock) throws -> T {
        return try T(midiRef: ARMIDI.createVirtualDestination(client: self.midiRef, name: name, midiProtocol: midiProtocol, block: block))
    }
}
