//
//  ARMIDIObject.swift
//  
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public class ARMIDIObject: ARMIDIObjectType {
    
    public let midiRef: MIDIObjectRef
    public let objectType: MIDIObjectType
    public var properties: [CFString: Any]?
    
    public convenience init(midiRef: MIDIObjectRef) throws {
        try self.init(midiRef: midiRef, objectType: .other)
    }
    
    public init(midiRef: MIDIObjectRef, objectType: MIDIObjectType) throws {
        self.midiRef = midiRef
        self.objectType = objectType
        self.properties = try getProperties(deep: true) as? [CFString: Any]
    }
    
    public func refreshProperties() throws -> [CFString: Any]? {
        let properties = try getProperties(deep: true) as? [CFString: Any]
        self.properties = properties
        return properties
    }
    
    public func name() throws -> String? {
        return try (self.properties?[kMIDIPropertyName] as? String)
        ?? self.refreshProperties()?[kMIDIPropertyName] as? String
    }
    
    public func name(newValue value: String) throws {
        try self.setStringProperty(kMIDIPropertyName, toValue: value)
        let _ = try self.refreshProperties()
    }
    
    internal func model() throws -> String? {
        return try (self.properties?[kMIDIPropertyModel] as? String)
        ?? self.refreshProperties()?[kMIDIPropertyModel] as? String
    }
    
    internal func model(newValue value: String) throws {
        try self.setStringProperty(kMIDIPropertyModel, toValue: value)
        let _ = try self.refreshProperties()
        return
    }
    
    internal func manufacturer() throws -> String? {
        return try self.getStringProperty(kMIDIPropertyManufacturer)
    }
    
    internal func manufacturer(newValue value: String) throws {
        return try self.setStringProperty(kMIDIPropertyManufacturer, toValue: value)
    }
    
    public func uniqueID() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertyUniqueID)
    }
    
    internal func uniqueID(newValue value: Int32) throws {
        return try setIntegerProperty(kMIDIPropertyUniqueID, toValue: value)
    }
    
    internal func deviceID() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertyDeviceID)
    }
    
    internal func deviceID(newValue value: Int32) throws {
        return try setIntegerProperty(kMIDIPropertyDeviceID, toValue: value)
    }
    
    internal func supportsMMC() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertySupportsMMC)
    }
    
    internal func supportsMMC(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertySupportsMMC, toValue: value)
    }
    
    internal func supportsGeneralMIDI() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertySupportsGeneralMIDI)
    }
    
    internal func supportsGeneralMIDI(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertySupportsGeneralMIDI, toValue: value)
    }
    
    internal func supportsShowControl() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertySupportsShowControl)
    }
    
    internal func supportsShowControl(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertySupportsShowControl, toValue: value)
    }
    
    internal func nameConfigurationDictionary() throws -> [CFString: Any]? {
        return try getDictionaryProperty(kMIDIPropertyNameConfigurationDictionary)
    }
    
    internal func nameConfigurationDictionary(newValue value: [CFString: Any]) throws {
        return try setDictionaryProperty(kMIDIPropertyNameConfigurationDictionary, toValue: value)
    }
        
    internal func maxSysExSpeed() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertyMaxSysExSpeed)
    }
        
    internal func maxSysExSpeed(newValue value: Int32) throws {
        return try setIntegerProperty(kMIDIPropertyMaxSysExSpeed, toValue: value)
    }
    
    internal func driverDeviceEditorApp() throws -> String? {
        return try self.getStringProperty(kMIDIPropertyDriverDeviceEditorApp)
    }
    
    internal func driverDeviceEditorApp(newValue value: String) throws {
        return try self.setStringProperty(kMIDIPropertyDriverDeviceEditorApp, toValue: value)
    }
    
    internal func image() throws -> String? {
        return try self.getStringProperty(kMIDIPropertyImage)
    }
    
    internal func image(newValue value: String) throws {
        return try self.setStringProperty(kMIDIPropertyImage, toValue: value)
    }
    
    internal func displayName() throws -> String? {
        return try self.getStringProperty(kMIDIPropertyDisplayName)
    }
    
    internal func displayName(newValue value: String) throws {
        return try self.setStringProperty(kMIDIPropertyDisplayName, toValue: value)
    }
    
    internal func panDisruptsStereo() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyPanDisruptsStereo)
    }
    
    internal func panDisruptsStereo(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyPanDisruptsStereo, toValue: value)
    }
    
    @available(macOS 11.0, *)
    internal func protocolID() throws -> MIDIProtocolID? {
        guard let protocolID = try getIntegerProperty(kMIDIPropertyProtocolID) else  { return nil }
        return MIDIProtocolID(rawValue: protocolID)
    }
    
    internal func transmitsMTC() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyTransmitsMTC)
    }
    
    internal func transmitsMTC(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyTransmitsMTC, toValue: value)
    }
    
    internal func receivesMTC() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyReceivesMTC)
    }
    
    internal func receivesMTC(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyReceivesMTC, toValue: value)
    }
    
    internal func transmitsClock() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyTransmitsClock)
    }
    
    internal func transmitsClock(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyTransmitsClock, toValue: value)
    }
    
    internal func receivesClock() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyReceivesClock)
    }
    
    internal func receivesClock(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyReceivesClock, toValue: value)
    }
    
    internal func advanceScheduleTimeMuSec() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertyAdvanceScheduleTimeMuSec)
    }
        
    internal func advanceScheduleTimeMuSec(newValue value: Int32) throws {
        return try setIntegerProperty(kMIDIPropertyAdvanceScheduleTimeMuSec, toValue: value)
    }
    
    internal func isMixer() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyIsMixer)
    }
    
    internal func isMixer(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyIsMixer, toValue: value)
    }
    
    internal func isSampler() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyIsSampler)
    }
    
    internal func isSampler(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyIsSampler, toValue: value)
    }
    
    internal func isEffectUnit() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyIsEffectUnit)
    }
    
    internal func isEffectUnit(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyIsEffectUnit, toValue: value)
    }
    
    internal func isDrumMachine() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyIsDrumMachine)
    }
    
    internal func isDrumMachine(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyIsDrumMachine, toValue: value)
    }
    
    internal func isOffline() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyOffline)
    }
    
    internal func isOffline(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyOffline, toValue: value)
    }
    
    internal func isPrivate() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyPrivate)
    }
    
    internal func isPrivate(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyPrivate, toValue: value)
    }
    
    internal func driverOwner() throws -> String? {
        return try self.getStringProperty(kMIDIPropertyDriverOwner)
    }
    
    internal func driverOwner(newValue value: String) throws {
        return try self.setStringProperty(kMIDIPropertyDriverOwner, toValue: value)
    }
    
    internal func driverVersion() throws -> String? {
        return try self.getStringProperty(kMIDIPropertyDriverVersion)
    }
    
    internal func driverVersion(newValue value: String) throws {
        return try self.setStringProperty(kMIDIPropertyDriverVersion, toValue: value)
    }
    
    internal func canRoute() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyCanRoute)
    }
    
    internal func canRoute(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyCanRoute, toValue: value)
    }
    
    internal func isBroadcast() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyIsBroadcast)
    }
    
    internal func isBroadcast(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyIsBroadcast, toValue: value)
    }
    
    internal func connectionUniqueID() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertyConnectionUniqueID)
    }
    
    internal func connectionUniqueID(newValue value: Int32) throws {
        return try setIntegerProperty(kMIDIPropertyConnectionUniqueID, toValue: value)
    }
    
    internal func isEmbeddedEntity() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyIsEmbeddedEntity)
    }
    
    internal func isEmbeddedEntity(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyIsEmbeddedEntity, toValue: value)
    }
    
    internal func singleRealtimeEntity() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertySingleRealtimeEntity)
    }
    
    internal func singleRealtime(newValue value: Int32) throws {
        return try setIntegerProperty(kMIDIPropertySingleRealtimeEntity, toValue: value)
    }
    
    internal func receiveChannels() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertyReceiveChannels)
    }
    
    internal func receiveChannels(newValue value: Int32) throws {
        return try setIntegerProperty(kMIDIPropertyReceiveChannels, toValue: value)
    }
    
    internal func transmitChannels() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertyTransmitChannels)
    }
    
    internal func transmitChannels(newValue value: Int32) throws {
        return try setIntegerProperty(kMIDIPropertyTransmitChannels, toValue: value)
    }
    
    internal func maxReceiveChannels() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertyMaxReceiveChannels)
    }
    
    internal func maxReceiveChannels(newValue value: Int32) throws {
        return try setIntegerProperty(kMIDIPropertyMaxReceiveChannels, toValue: value)
    }
    
    internal func maxTransmitChannels() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertyMaxTransmitChannels)
    }
    
    internal func maxTransmitChannels(newValue value: Int32) throws {
        return try setIntegerProperty(kMIDIPropertyMaxTransmitChannels, toValue: value)
    }
    
    internal func receivesBankSelectLSB() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyReceivesBankSelectLSB)
    }
    
    internal func receivesBankSelectLSB(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyReceivesBankSelectLSB, toValue: value)
    }
    
    internal func receivesBankSelectMSB() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyReceivesBankSelectMSB)
    }
    
    internal func receivesBankSelectMSB(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyReceivesBankSelectMSB, toValue: value)
    }
    
    internal func transmitsBankSelectLSB() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyTransmitsBankSelectLSB)
    }
    
    internal func transmitsBankSelectLSB(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyTransmitsBankSelectLSB, toValue: value)
    }
    
    internal func transmitsBankSelectMSB() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyTransmitsBankSelectMSB)
    }
    
    internal func transmitsBankSelectMSB(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyTransmitsBankSelectMSB, toValue: value)
    }
    
    internal func receivesNotes() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyReceivesNotes)
    }
    
    internal func receivesNotes(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyReceivesNotes, toValue: value)
    }
    
    internal func transmitsNotes() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyTransmitsNotes)
    }
    
    internal func transmitsNotes(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyTransmitsNotes, toValue: value)
    }
    
    internal func receivesProgramChanges() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyReceivesProgramChanges)
    }
    
    internal func receivesProgramChanges(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyReceivesProgramChanges, toValue: value)
    }
    
    internal func transmitsProgramChanges() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyTransmitsProgramChanges)
    }
    
    internal func transmitsProgramChanges(newValue value: Bool) throws {
        return try setBooleanProperty(kMIDIPropertyTransmitsProgramChanges, toValue: value)
    }
}
