//
//  ARMIDIServices+Protocols.swift
//  ARMIDI/ARMIDIServices+Protocols/Sources/ARMIDIServices+Protocols.swift
//
//  Created by Aaron Rasmussen on 9/20/24.
//

import CoreMIDI

public protocol ARMIDIRef {
    var midiRef: UInt32 { get }
    
    func objectGetProperties(deep: Bool) throws -> CFPropertyList?
    func objectRemoveProperty(_ property: CFString) throws
    func objectGetStringProperty(_ property: CFString) throws -> String?
    func objectSetStringProperty(_ property: CFString, toValue value: String) throws
    func objectGetIntegerProperty(_ property: CFString) throws -> Int32?
    func objectSetIntegerProperty(_ property: CFString, toValue value: Int32) throws
    func objectGetDataProperty(_ property: CFString) throws -> Data?
    func objectSetDataProperty(_ property: CFString, toValue value: Data) throws
    func objectGetDictionaryProperty(_ property: CFString) throws -> [CFString: Any]?
    func objectSetDictionaryProperty(_ property: CFString, toValue value: [CFString: Any]) throws
    
    func deviceNumberOfEntities() -> Int
    func deviceEntityAtIndex(_ index: Int) -> MIDIEntityRef
    func deviceEntities() -> [MIDIEntityRef]
    
    func entityDevice() throws -> MIDIDeviceRef
    func entityNumberOfSources() -> Int
    func entitySourceAtIndex(_ index: Int) -> MIDIEndpointRef
    func entitySources() -> [MIDIEndpointRef]
    func entityNumberOfDestinations() -> Int
    func entityDestinationAtIndex(_ index: Int) -> MIDIEndpointRef
    func entityDestinations() -> [MIDIEndpointRef]
    
    func clientCreateInputPortNamed(_ name: String, usingCallback callback: MIDIReadProc, context: UnsafeMutableRawPointer?) throws -> MIDIEndpointRef
    func clientCreateInputPortNamed(_ name: String, usingBlock block: @escaping MIDIReadBlock) throws -> MIDIEndpointRef
    @available(macOS 11.0, *)
    func clientCreateInputPortNamed(_ name: String, usingProtocol midiProtocol: MIDIProtocolID, withBlock block: @escaping MIDIReceiveBlock) throws -> MIDIPortRef
    func clientCreateOutputPortNamed(_ name: String) throws -> MIDIPortRef
    func clientCreateSourceNamed(_ name: String) throws -> MIDIEndpointRef
    @available(macOS 11.0, *)
    func clientCreateSourceNamed(_ name: String, usingProtocol midiProtocol: MIDIProtocolID) throws -> MIDIEndpointRef
    func clientCreateDestinationNamed(_ name: String, withCallback callback: MIDIReadProc, context: UnsafeMutableRawPointer?) throws -> MIDIEndpointRef
    func clientCreateDestinationNamed(_ name: String, withBlock block: @escaping MIDIReadBlock) throws -> MIDIEndpointRef
    @available(macOS 11.0, *)
    func clientCreateDestinationNamed(_ name: String, usingProtocol midiProtocol: MIDIProtocolID, withBlock block: @escaping MIDIReceiveBlock) throws -> MIDIEndpointRef
    
    func portConnectToSource(_ source: MIDIEndpointRef, context: UnsafeMutableRawPointer?) throws
    func portDisconnectFromSource(_ source: MIDIEndpointRef) throws
    
    func endpointEntity() throws -> MIDIEntityRef
    func endpointFlushOutput() throws
}
