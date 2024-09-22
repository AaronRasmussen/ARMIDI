//
//  ARMIDIServices.swift
//  ARMIDI/ARMIDIServices/Sources/ARMIDIServices.swift
//
//  Created by Aaron Rasmussen on 9/19/24.
//

import CoreMIDI

public func findObectWith(uniqueID: MIDIUniqueID) throws -> (MIDIObjectRef, MIDIObjectType) {
    var midiRef: MIDIObjectRef = 0
    var objectType: MIDIObjectType = .other
    let status = MIDIObjectFindByUniqueID(uniqueID, &midiRef, &objectType)
    guard status == 0 else { throw ARMIDIError(status) }
    return (midiRef, objectType)
}

public func getPropertiesForObject(_ object: MIDIObjectRef, deep: Bool) throws -> CFPropertyList? {
    var properties: Unmanaged<CFPropertyList>? = nil
    let status = MIDIObjectGetProperties(object, &properties, deep)
    guard status == 0 else { throw ARMIDIError(status) }
    return properties?.takeUnretainedValue()
}

public func removePropertyFromObject(_ object: MIDIObjectRef, property: CFString) throws {
    let status = MIDIObjectRemoveProperty(object, property)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func getStringPropertyForObject(_ object: MIDIObjectRef, property: CFString) throws -> String? {
    var stringProperty: Unmanaged<CFString>? = nil
    let status = MIDIObjectGetStringProperty(object, property, &stringProperty)
    guard status != kMIDIUnknownProperty else { return nil }
    guard status == 0 else { throw ARMIDIError(status) }
    return stringProperty?.takeUnretainedValue() as? String
}

public func setStringPropertyForObject(_ object: MIDIObjectRef, property: CFString, toValue value: String) throws {
    let status = MIDIObjectSetStringProperty(object, property, value as CFString)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func getIntegerPropertyForObject(_ object: MIDIObjectRef, property: CFString) throws -> Int32? {
    var integerProperty: Int32 = 0
    let status = MIDIObjectGetIntegerProperty(object, property, &integerProperty)
    guard status != kMIDIUnknownProperty else { return nil }
    guard status == 0 else { throw ARMIDIError(status) }
    return integerProperty
}

public func setIntegerPropertyForObject(_ object: MIDIObjectRef, property: CFString, toValue value: Int32) throws {
    let status = MIDIObjectSetIntegerProperty(object, property, value)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func getBooleanPropertyForObject(_ object: MIDIObjectRef, property: CFString) throws -> Bool? {
    guard let integerValue = try getIntegerPropertyForObject(object, property: property) else { return nil }
    return integerValue != 0
}

public func setBooleanPropertyForObject(_ object: MIDIObjectRef, property: CFString, toValue value: Bool) throws {
    return try setIntegerPropertyForObject(object, property: property, toValue: value ? 1 : 0)
}

public func getDataPropertyForObject(_ object: MIDIObjectRef, property: CFString) throws -> Data? {
    var data: Unmanaged<CFData>? = nil
    let status = MIDIObjectGetDataProperty(object, property, &data)
    guard status != kMIDIUnknownProperty else { return nil }
    guard status == 0 else { throw ARMIDIError(status) }
    return data?.takeUnretainedValue() as Data?
}

public func setDataPropertyForObject(_ object: MIDIObjectRef, property: CFString, toValue value: Data) throws {
    let status = MIDIObjectSetDataProperty(object, property, value as CFData)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func getDictionaryPropertyForObject(_ object: MIDIObjectRef, property: CFString) throws -> [CFString: Any]? {
    var dictionary: Unmanaged<CFDictionary>? = nil
    let status = MIDIObjectGetDictionaryProperty(object, property, &dictionary)
    guard status != kMIDIUnknownProperty else { return nil }
    guard status == 0 else { throw ARMIDIError(status) }
    return dictionary?.takeUnretainedValue() as? [CFString: Any]
}

public func setDictionaryPropertyForObject(_ object: MIDIObjectRef, property: CFString, toValue value: [CFString: Any]) throws {
    let status = MIDIObjectSetDictionaryProperty(object, property, value as CFDictionary)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func createClientNamed(_ name: String, withCallback callback: MIDINotifyProc?, context: UnsafeMutableRawPointer?) throws -> MIDIClientRef {
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

public func disposeOfClient(_ client: MIDIClientRef) throws {
    let status = MIDIClientDispose(client)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func numberOfDevices() -> Int {
    return MIDIGetNumberOfDevices()
}

public func deviceAtIndex(_ index: Int) -> MIDIDeviceRef {
    return MIDIGetDevice(index)
}

public func devices() -> [MIDIDeviceRef] {
    return (0..<MIDIGetNumberOfDevices()).map { MIDIGetDevice($0) }
}

public func numberOfExternalDevices() -> Int {
    return MIDIGetNumberOfExternalDevices()
}

public func externalDeviceAtIndex(_ index: Int) -> MIDIDeviceRef {
    return MIDIGetDevice(index)
}

public func externalDevices() -> [MIDIDeviceRef] {
    return (0..<MIDIGetNumberOfExternalDevices()).map { MIDIGetExternalDevice($0) }
}

public func numberOfEntitiesForDevice(_ device: MIDIDeviceRef) -> Int {
    return MIDIDeviceGetNumberOfEntities(device)
}

public func entityAtIndexForDevice(_ device: MIDIDeviceRef, index: Int) -> MIDIEntityRef {
    return MIDIDeviceGetEntity(device, index)
}

public func entitiesForDevice(_ device: MIDIDeviceRef) -> [MIDIEntityRef] {
    return (0..<numberOfEntitiesForDevice(device)).map {
        return entityAtIndexForDevice(device, index: $0)
    }
}

public func deviceForEntity(_ entity: MIDIEntityRef) throws -> MIDIDeviceRef {
    var device: MIDIDeviceRef = 0
    let status = MIDIEntityGetDevice(entity, &device)
    guard status == 0 else { throw ARMIDIError(status) }
    return device
}

public func numberOfSourcesForEntity(_ entity: MIDIEntityRef) -> Int {
    return MIDIEntityGetNumberOfSources(entity)
}

public func sourceAtIndexForEntity(_ entity: MIDIEntityRef, index: Int) -> MIDIEndpointRef {
    return MIDIEntityGetSource(entity, index)
}

public func sourcesForEntity(_ entity: MIDIEntityRef) -> [MIDIEndpointRef] {
    return (0..<numberOfSourcesForEntity(entity)).map {
        return sourceAtIndexForEntity(entity, index: $0)
    }
}

public func numberOfDestinationsForEntity(_ entity: MIDIEntityRef) -> Int {
    return MIDIEntityGetNumberOfDestinations(entity)
}

public func destinationAtIndexForEntity(_ entity: MIDIEndpointRef, index: Int) -> MIDIEndpointRef {
    return MIDIEntityGetDestination(entity, index)
}

public func destinationsForEntity(_ entity: MIDIEntityRef) -> [MIDIEndpointRef] {
    return (0..<numberOfDestinationsForEntity(entity)).map {
        destinationAtIndexForEntity(entity, index: $0)
    }
}

public func createInputPortForClient(_ client: MIDIClientRef, named name: String, usingCallback callback: MIDIReadProc, context: UnsafeMutableRawPointer?) throws -> MIDIEndpointRef {
    var port: MIDIPortRef = 0
    let status = MIDIInputPortCreate(client, name as CFString, callback, context, &port)
    guard status == 0 else { throw ARMIDIError(status) }
    return port
}

public func createInputPortForClient(_ client: MIDIClientRef, named name: String, usingBlock block: @escaping MIDIReadBlock) throws -> MIDIEndpointRef {
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

public func disposeOfPort(_ portRef: MIDIPortRef) throws {
    let status = MIDIPortDispose(portRef)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func connectPort(_ port: MIDIPortRef, toSource source: MIDIEndpointRef, context: UnsafeMutableRawPointer?) throws {
    let status = MIDIPortConnectSource(port, source, context)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func disconnectPort(_ port: MIDIPortRef, fromSource source: MIDIEndpointRef) throws {
    let status = MIDIPortDisconnectSource(port, source)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func disposeOfEndpoint(_ endpointRef: MIDIEndpointRef) throws {
    let status = MIDIEndpointDispose(endpointRef)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func entityForEndpoint(_ endpoint: MIDIEndpointRef) throws -> MIDIEntityRef {
    var entity: MIDIEntityRef = 0
    let status = MIDIEndpointGetEntity(endpoint, &entity)
    guard status == 0 else { throw ARMIDIError(status) }
    return entity
}

// public func getRefConsForEndpoint( UNDEFINED )
// puboic func setRefConsForEndpoint( UNDEFINED )

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

public func numberOfSources() -> Int {
    return MIDIGetNumberOfSources()
}

public func sourceAtIndex(_ index: Int) -> MIDIEndpointRef {
    return MIDIGetSource(index)
}

public func sources() -> [MIDIEndpointRef] {
    return (0..<numberOfSources()).map {
        sourceAtIndex($0)
    }
}

public func createDestinationForClient(_ client: MIDIClientRef, named name: String, withCallback callback: MIDIReadProc, context: UnsafeMutableRawPointer?) throws -> MIDIEndpointRef {
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

public func numberOfDestinations() -> Int {
    return MIDIGetNumberOfDestinations()
}

public func destinationAtIndex(_ index: Int) -> MIDIEndpointRef {
    return MIDIGetDevice(index)
}

public func destinations() -> [MIDIEndpointRef] {
    return (0..<numberOfDestinations()).map {
        destinationAtIndex($0)
    }
}

public func initializePacketList(_ packetList: inout MIDIPacketList) -> UnsafeMutablePointer<MIDIPacket> {
    return MIDIPacketListInit(&packetList)
}

@available(macOS 11.0, *)
public func initializeEventList(_ eventList: inout MIDIEventList, usingProtocol midiProtocol: MIDIProtocolID) -> UnsafeMutablePointer<MIDIEventPacket> {
    return MIDIEventListInit(&eventList, midiProtocol)
}

public func addToPacketList(_ packetList: inout MIDIPacketList, listSize: Int, currentPacket: inout MIDIPacket, time: MIDITimeStamp, dataCount: Int, data: [UInt8]) -> UnsafeMutablePointer<MIDIPacket> {
    return MIDIPacketListAdd(&packetList, listSize, &currentPacket, time, dataCount, data)
}

@available(macOS 11.0, *)
public func addToEventList(_ eventList: inout MIDIEventList, listSize: Int, currentPacket: inout MIDIEventPacket, time: MIDITimeStamp, wordCount: Int, words: [UInt32]) -> UnsafeMutablePointer<MIDIEventPacket> {
    return MIDIEventListAdd(&eventList, listSize, &currentPacket, time, wordCount, words)
}

public func nextEventPacket(currentPacket: inout MIDIEventPacket) -> UnsafeMutablePointer<MIDIEventPacket> {
    return MIDIEventPacketNext(&currentPacket)
}

public func sendPacketList(_ packetList: inout MIDIPacketList, fromPort port: MIDIPortRef, toDestination destination: MIDIEndpointRef) throws {
    let status = MIDISend(port, destination, &packetList)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func distributePacketList(_ packetList: inout MIDIPacketList, fromSource source: MIDIEndpointRef) throws {
    let status = MIDIReceived(source, &packetList)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

@available(macOS 11.0, *)
public func sendEventList(_ eventList: inout MIDIEventList, fromPort port: MIDIPortRef, toDestination destination: MIDIEndpointRef) throws {
    let status = MIDISendEventList(port, destination, &eventList)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

@available(macOS 11.0, *)
public func distributeEventList(_ eventList: inout MIDIEventList, fromSource source: MIDIEndpointRef) throws {
    let status = MIDIReceivedEventList(source, &eventList)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func nextPacket(_ currentPacket: inout MIDIPacket) -> UnsafeMutablePointer<MIDIPacket> {
    return MIDIPacketNext(&currentPacket)
}

public func flushOutput(endpoint: MIDIEndpointRef) throws {
    let status = MIDIFlushOutput(endpoint)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func restart() throws {
    let status = MIDIRestart()
    guard status == 0 else { throw ARMIDIError(status) }
    return
}
