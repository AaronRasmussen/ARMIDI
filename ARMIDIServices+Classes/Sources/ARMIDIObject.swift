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
    
    public required convenience init(midiRef: MIDIObjectRef) throws {
        try self.init(midiRef: midiRef, objectType: .other)
    }
    
    init(midiRef: MIDIObjectRef, objectType: MIDIObjectType) throws {
        self.midiRef = midiRef
        self.objectType = objectType
        self.properties = try self.getProperties(deep: true) as? [CFString: Any]
    }
    
    public func refreshProperties() throws {
        self.properties = nil
        self.properties = try self.getProperties(deep: true) as? [CFString: Any]
    }
    
    public func name() throws -> String? {
        return self.properties?[kMIDIPropertyName] as? String
    }
    
    internal func name(newValue v: String) throws {
        try self.setStringProperty(toValue: v, property: kMIDIPropertyName)
        try self.refreshProperties()
    }
    
    public func model() throws -> String? {
        return self.properties?[kMIDIPropertyModel] as? String
    }
    
    internal func model(newValue v: String) throws {
        try self.setStringProperty(toValue: v, property: kMIDIPropertyModel)
        try self.refreshProperties()
    }
    
    public func manufacturer() throws -> String? {
        return self.properties?[kMIDIPropertyManufacturer] as? String
    }
    
    internal func manufacturer(newValue v: String) throws {
        try self.setStringProperty(toValue: v, property: kMIDIPropertyManufacturer)
        try self.refreshProperties()
    }
    
    public func uniqueID() throws -> Int32? {
        return self.properties?[kMIDIPropertyUniqueID] as? Int32
    }
    
    internal func uniqueID(newValue v: Int32) throws {
        try self.setIntegerProperty(toValue: v, property: kMIDIPropertyUniqueID)
        try self.refreshProperties()
    }
    
    internal func deviceID() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertyDeviceID)
    }
    
    internal func deviceID(newValue v: Int32) throws {
        try setIntegerProperty(toValue: v, property: kMIDIPropertyDeviceID)
        try self.refreshProperties()
    }
    
    internal func supportsMMC() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertySupportsMMC)
    }
    
    internal func supportsMMC(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertySupportsMMC)
        try self.refreshProperties()
    }
    
    internal func supportsGeneralMIDI() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertySupportsGeneralMIDI)
    }
    
    internal func supportsGeneralMIDI(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertySupportsGeneralMIDI)
        try self.refreshProperties()
    }
    
    internal func supportsShowControl() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertySupportsShowControl)
    }
    
    internal func supportsShowControl(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertySupportsShowControl)
        try self.refreshProperties()
    }
    
    internal func nameConfigurationDictionary() throws -> [CFString: Any]? {
        return try getDictionaryProperty(kMIDIPropertyNameConfigurationDictionary)
    }
    
    internal func nameConfigurationDictionary(newValue v: [CFString: Any]) throws {
        try setDictionaryProperty(toValue: v, property: kMIDIPropertyNameConfigurationDictionary)
        try self.refreshProperties()
    }
        
    internal func maxSysExSpeed() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertyMaxSysExSpeed)
    }
        
    internal func maxSysExSpeed(newValue v: Int32) throws {
        try setIntegerProperty(toValue: v, property: kMIDIPropertyMaxSysExSpeed)
        try self.refreshProperties()
    }
    
    internal func driverDeviceEditorApp() throws -> String? {
        return try self.getStringProperty(kMIDIPropertyDriverDeviceEditorApp)
    }
    
    internal func driverDeviceEditorApp(newValue v: String) throws {
        try self.setStringProperty(toValue: v, property: kMIDIPropertyDriverDeviceEditorApp)
        try self.refreshProperties()
    }
    
    internal func image() throws -> String? {
        return try self.getStringProperty(kMIDIPropertyImage)
    }
    
    internal func image(newValue v: String) throws {
        try self.setStringProperty(toValue: v, property: kMIDIPropertyImage)
        try self.refreshProperties()
    }
    
    internal func displayName() throws -> String? {
        return try self.getStringProperty(kMIDIPropertyDisplayName)
    }
    
    internal func displayName(newValue v: String) throws {
        try self.setStringProperty(toValue: v, property: kMIDIPropertyDisplayName)
        try self.refreshProperties()
    }
    
    internal func panDisruptsStereo() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyPanDisruptsStereo)
    }
    
    internal func panDisruptsStereo(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyPanDisruptsStereo)
        try self.refreshProperties()
    }
    
    @available(macOS 11.0, *)
    internal func protocolID() throws -> MIDIProtocolID? {
        guard let protocolID = try getIntegerProperty(kMIDIPropertyProtocolID) else  { return nil }
        return MIDIProtocolID(rawValue: protocolID)
    }
    
    internal func transmitsMTC() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyTransmitsMTC)
    }
    
    internal func transmitsMTC(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyTransmitsMTC)
        try self.refreshProperties()
    }
    
    internal func receivesMTC() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyReceivesMTC)
    }
    
    internal func receivesMTC(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyReceivesMTC)
        try self.refreshProperties()
    }
    
    internal func transmitsClock() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyTransmitsClock)
    }
    
    internal func transmitsClock(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyTransmitsClock)
        try self.refreshProperties()
    }
    
    internal func receivesClock() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyReceivesClock)
    }
    
    internal func receivesClock(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyReceivesClock)
        try self.refreshProperties()
    }
    
    internal func advanceScheduleTimeMuSec() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertyAdvanceScheduleTimeMuSec)
    }
        
    internal func advanceScheduleTimeMuSec(newValue v: Int32) throws {
        try setIntegerProperty(toValue: v, property: kMIDIPropertyAdvanceScheduleTimeMuSec)
        try self.refreshProperties()
    }
    
    internal func isMixer() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyIsMixer)
    }
    
    internal func isMixer(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyIsMixer)
        try self.refreshProperties()
    }
    
    internal func isSampler() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyIsSampler)
    }
    
    internal func isSampler(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyIsSampler)
        try self.refreshProperties()
    }
    
    internal func isEffectUnit() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyIsEffectUnit)
    }
    
    internal func isEffectUnit(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyIsEffectUnit)
        try self.refreshProperties()
    }
    
    internal func isDrumMachine() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyIsDrumMachine)
    }
    
    internal func isDrumMachine(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyIsDrumMachine)
        try self.refreshProperties()
    }
    
    internal func isOffline() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyOffline)
    }
    
    internal func isOffline(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyOffline)
        try self.refreshProperties()
    }
    
    internal func isPrivate() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyPrivate)
    }
    
    internal func isPrivate(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyPrivate)
        try self.refreshProperties()
    }
    
    internal func driverOwner() throws -> String? {
        return try self.getStringProperty(kMIDIPropertyDriverOwner)
    }
    
    internal func driverOwner(newValue v: String) throws {
        try self.setStringProperty(toValue: v, property: kMIDIPropertyDriverOwner)
        try self.refreshProperties()
    }
    
    internal func driverVersion() throws -> String? {
        return try self.getStringProperty(kMIDIPropertyDriverVersion)
    }
    
    internal func driverVersion(newValue v: String) throws {
        try self.setStringProperty(toValue: v, property: kMIDIPropertyDriverVersion)
        try self.refreshProperties()
    }
    
    internal func canRoute() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyCanRoute)
    }
    
    internal func canRoute(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyCanRoute)
        try self.refreshProperties()
    }
    
    internal func isBroadcast() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyIsBroadcast)
    }
    
    internal func isBroadcast(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyIsBroadcast)
        try self.refreshProperties()
    }
    
    internal func connectionUniqueID() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertyConnectionUniqueID)
    }
    
    internal func connectionUniqueID(newValue v: Int32) throws {
        try setIntegerProperty(toValue: v, property: kMIDIPropertyConnectionUniqueID)
        try self.refreshProperties()
    }
    
    internal func isEmbeddedEntity() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyIsEmbeddedEntity)
    }
    
    internal func isEmbeddedEntity(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyIsEmbeddedEntity)
        try self.refreshProperties()
    }
    
    internal func singleRealtimeEntity() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertySingleRealtimeEntity)
    }
    
    internal func singleRealtime(newValue v: Int32) throws {
        try setIntegerProperty(toValue: v, property: kMIDIPropertySingleRealtimeEntity)
        try self.refreshProperties()
    }
    
    internal func receiveChannels() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertyReceiveChannels)
    }
    
    internal func receiveChannels(newValue v: Int32) throws {
        try setIntegerProperty(toValue: v, property: kMIDIPropertyReceiveChannels)
        try self.refreshProperties()
    }
    
    internal func transmitChannels() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertyTransmitChannels)
    }
    
    internal func transmitChannels(newValue v: Int32) throws {
        try setIntegerProperty(toValue: v, property: kMIDIPropertyTransmitChannels)
        try self.refreshProperties()
    }
    
    internal func maxReceiveChannels() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertyMaxReceiveChannels)
    }
    
    internal func maxReceiveChannels(newValue v: Int32) throws {
        try setIntegerProperty(toValue: v, property: kMIDIPropertyMaxReceiveChannels)
        try self.refreshProperties()
    }
    
    internal func maxTransmitChannels() throws -> Int32? {
        return try getIntegerProperty(kMIDIPropertyMaxTransmitChannels)
    }
    
    internal func maxTransmitChannels(newValue v: Int32) throws {
        try setIntegerProperty(toValue: v, property: kMIDIPropertyMaxTransmitChannels)
        try self.refreshProperties()
    }
    
    internal func receivesBankSelectLSB() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyReceivesBankSelectLSB)
    }
    
    internal func receivesBankSelectLSB(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyReceivesBankSelectLSB)
        try self.refreshProperties()
    }
    
    internal func receivesBankSelectMSB() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyReceivesBankSelectMSB)
    }
    
    internal func receivesBankSelectMSB(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyReceivesBankSelectMSB)
        try self.refreshProperties()
    }
    
    internal func transmitsBankSelectLSB() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyTransmitsBankSelectLSB)
    }
    
    internal func transmitsBankSelectLSB(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyTransmitsBankSelectLSB)
        try self.refreshProperties()
    }
    
    internal func transmitsBankSelectMSB() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyTransmitsBankSelectMSB)
    }
    
    internal func transmitsBankSelectMSB(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyTransmitsBankSelectMSB)
        try self.refreshProperties()
    }
    
    internal func receivesNotes() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyReceivesNotes)
    }
    
    internal func receivesNotes(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyReceivesNotes)
        try self.refreshProperties()
    }
    
    internal func transmitsNotes() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyTransmitsNotes)
    }
    
    internal func transmitsNotes(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyTransmitsNotes)
        try self.refreshProperties()
    }
    
    internal func receivesProgramChanges() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyReceivesProgramChanges)
    }
    
    internal func receivesProgramChanges(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyReceivesProgramChanges)
        try self.refreshProperties()
    }
    
    internal func transmitsProgramChanges() throws -> Bool? {
        return try getBooleanProperty(kMIDIPropertyTransmitsProgramChanges)
    }
    
    internal func transmitsProgramChanges(newValue v: Bool) throws {
        try setBooleanProperty(toValue: v, property: kMIDIPropertyTransmitsProgramChanges)
        try self.refreshProperties()
    }
}
