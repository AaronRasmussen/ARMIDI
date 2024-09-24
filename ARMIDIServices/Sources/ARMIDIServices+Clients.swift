//
//  ARMIDIServices+Clients.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public func createClientNamed(_ name: String, withContext context: UnsafeMutableRawPointer?, withCallback callback: MIDINotifyProc?) throws -> MIDIClientRef {
    var client: MIDIClientRef = 0
    let status = MIDIClientCreate(name as CFString, callback, context , &client)
    guard status == 0 else { throw ARMIDIError(status) }
    return client
}

public func createClientNamed(_ name: String, withBlock block: MIDINotifyBlock?) throws -> MIDIClientRef {
    var client: MIDIClientRef = 0
    let status = MIDIClientCreateWithBlock(name as CFString, &client, block)
    guard status == 0 else { throw ARMIDIError(status) }
    return client
}

public func createInputPortForClient(_ client: MIDIClientRef, named name: String, withContext context: UnsafeMutableRawPointer?, usingCallback callback: @escaping MIDIReadProc) throws -> MIDIEndpointRef {
    var port: MIDIPortRef = 0
    let status = MIDIInputPortCreate(client, name as CFString, callback, context, &port)
    guard status == 0 else { throw ARMIDIError(status) }
    return port
}

public func createInputPortForClient(_ client: MIDIClientRef, named name: String, withBlock block: @escaping MIDIReadBlock) throws -> MIDIEndpointRef {
    var port: MIDIPortRef = 0
    let status = MIDIInputPortCreateWithBlock(client, name as CFString, &port, block)
    guard status == 0 else { throw ARMIDIError(status) }
    return port
}

@available(macOS 11.0, *)
public func createInputPortForClient(_ client: MIDIClientRef, named name: String, usingProtocol midiProtocol: MIDIProtocolID, withBlock block: @escaping MIDIReceiveBlock) throws -> MIDIPortRef {
    var port: MIDIPortRef = 0
    let status = MIDIInputPortCreateWithProtocol(client, name as CFString, midiProtocol, &port, block)
    guard status == 0 else { throw ARMIDIError(status) }
    return port
}

public func createOutputPortForClient(_ client: MIDIClientRef, named name: String) throws -> MIDIPortRef {
    var port: MIDIPortRef = 0
    let status = MIDIOutputPortCreate(client, name as CFString, &port)
    guard status == 0 else { throw ARMIDIError(status) }
    return port
}

public func createSourceForClient(_ client: MIDIClientRef, named name: String) throws -> MIDIEndpointRef {
    var source: MIDIEndpointRef = 0
    let status = MIDISourceCreate(client, name as CFString, &source)
    guard status == 0 else { throw ARMIDIError(status) }
    return source
}

@available(macOS 11.0, *)
public func createSourceForClient(_ client: MIDIClientRef, named name: String, usingProtocol midiProtocol: MIDIProtocolID) throws -> MIDIEndpointRef {
    var source: MIDIEndpointRef = 0
    let status = MIDISourceCreateWithProtocol(client, name as CFString, midiProtocol, &source)
    guard status == 0 else { throw ARMIDIError(status) }
    return source
}

public func createDestinationForClient(_ client: MIDIClientRef, named name: String, withContext context: UnsafeMutableRawPointer?, withCallback callback: @escaping MIDIReadProc) throws -> MIDIEndpointRef {
    var destination: MIDIEndpointRef = 0
    let status = MIDIDestinationCreate(client, name as CFString, callback, context, &destination)
    guard status == 0 else { throw ARMIDIError(status) }
    return destination
}

public func createDestinationForClient(_ client: MIDIClientRef, named name: String, withBlock block: @escaping MIDIReadBlock) throws -> MIDIEndpointRef {
    var destination: MIDIEndpointRef = 0
    let status = MIDIDestinationCreateWithBlock(client, name as CFString, &destination, block)
    guard status == 0 else { throw ARMIDIError(status) }
    return destination
}

@available(macOS 11.0, *)
public func createDestinationForClient(_ client: MIDIClientRef, named name: String, usingProtocol midiProtocol: MIDIProtocolID, withBlock block: @escaping MIDIReceiveBlock) throws -> MIDIEndpointRef {
    var destination: MIDIEndpointRef = 0
    let status = MIDIDestinationCreateWithProtocol(client, name as CFString, midiProtocol, &destination, block)
    guard status == 0 else { throw ARMIDIError(status) }
    return destination
}

public func disposeOfClient(_ client: MIDIClientRef) throws {
    let status = MIDIClientDispose(client)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}
