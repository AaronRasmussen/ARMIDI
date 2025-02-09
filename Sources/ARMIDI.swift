//
//  ARMIDI.swift
//  Pods
//
//  Created by Aaron Rasmussen on 2/4/25.
//

import CoreMIDI
import ARMIDIError

/// Search for the MIDI object with the given `MIDIUniqueID`.
///
/// `findObject(withUniqueID:)` is a Swift-friendly wrapper for `CoreMIDI`'s `MIDIObjectFindByUniqueID(_:_:_:)` function.
///
/// - Parameter uniqueID: The `MIDIUniqueID` used to search for the MIDI object.
///
/// - Returns: A tuple containing the `MIDIObjectRef` and `MIDIObjectType` of the MIDI object.
///
/// - Throws: `MIDIError`.  If the MIDI object is not found `MIDIError.objectNotFound` will be thrown.
public func findObject(withUniqueID uniqueID: MIDIUniqueID) throws -> (object: ObjectReferable, type: MIDIObjectType) {
    
    var object: MIDIObjectRef = 0
    var type: MIDIObjectType = .other
    
    let status = MIDIObjectFindByUniqueID(uniqueID, &object, &type)
    
    guard
        status == 0
    else {
        throw MIDIError(status)
    }
    
    return (object, type)
}

/// The number of internal MIDI devices in the MIDI system.
///
/// - Returns: The number of internal MIDI devices in the MIDI system.
public func numberOfDevices() -> Int {
    return MIDIGetNumberOfDevices() as Int
}

/// The internal MIDI device in the MIDI system at the provided index.
///
/// - Parameter index: The index of the internal MIDI device to return.
///
/// - Returns: The `MIDIDeviceRef` of the internal MIDI device in the MIDI system at the provided index.
public func device(atIndex index: Int) -> DeviceReferable {
    return MIDIGetDevice(index)
}

/// An array of all internal MIDI devices in the system.
///
/// - Returns: An `Array<MIDIDeviceRef>` of all internal MIDI devices in the system.
public func devices() -> [DeviceReferable] {
    (0..<numberOfDevices()).map(device)
}

/// The number of MIDI sources in the MIDI system.
///
/// - Returns: The number of MIDI sources in the MIDI system.
public func numberOfSources() -> Int {
    return MIDIGetNumberOfSources() as Int
}

/// The number of MIDI destinations in the MIDI system.
///
/// - Returns: The number of MIDI destinations in the MIDI system.
public func numberOfDestinations() -> Int {
    return MIDIGetNumberOfDestinations() as Int
}

/// The MIDI source in the MIDI system at the provided index.
///
/// - Parameter index: The index of the MIDI source to return.
///
/// - Returns: The `MIDIEndpointRef` of the MIDI source in the MIDI system at the provided index.
public func source(atIndex index: Int) -> SourceReferable {
    return MIDIGetSource(index)
}

/// The MIDI destination in the MIDI system at the provided index.
///
/// - Parameter index: The index of the MIDI destination to return.
///
/// - Returns: The `MIDIEndpointRef` of the MIDI destination in the MIDI system at the provided index.
public func destination(atIndex index: Int) -> EndpointReferable {
    return MIDIGetDestination(index)
}

/// An array of all MIDI sources in the MIDI system.
///
/// - Returns: An `Array<MIDIEndpointRef>` of all MIDI sources in the MIDI system.
public func sources() -> [SourceReferable] {
    return (0..<numberOfSources()).map(source)
}

/// An array of all MIDI destinations in the MIDI system.
///
/// - Returns: An `Array<MIDIEndpointRef>` of all MIDI destinations in the MIDI system.
public func destinations() -> [EndpointReferable] {
    return (0..<numberOfDestinations()).map(destination)
}

/// A system exclusive MIDI message.
///
/// `SysexMessage` is used to send a MIDI system exclusive message to a MIDI destination.
///
/// An empty `SysexMessage` is created using `SysexMessage()`. The data to send, the destination to send it to, and an optional completion handler are suppled wihen calling the `send(sysexData:to:completionhandler:)` instance method.
public class SysexMessage {
    
    fileprivate var data: [UInt8] = []
    fileprivate var handle: ((MIDISysexSendRequest) -> Void)?
    fileprivate var sendRequest: MIDISysexSendRequest!
    
    /// Initialize a `SysexMessage`.
    public init() { }
    
    /// Send a `SysexMessage` to a MIDI destination with an optional completion handler.
    ///
    /// - Parameters:
    ///   - sysexData: The data to send. The array should begin with the MIDI system exclusive status byte `0xF0` and end with the `EOX` status byte `0xF7`.
    ///   - destination: The MIDI destination that will receive the message.
    ///   - completionHandler: A completion handler that will be called when the transmission is complete.
    /// - Throws: `MIDIError`
    public func send(sysexData: [UInt8], to destination: DestinationReferable, completionHandler: ((MIDISysexSendRequest) -> ())?) throws {
        
        self.data = sysexData
        self.handle = completionHandler
        let byteCount: UInt32 = UInt32(self.data.count)
        
        self.sendRequest = withUnsafeMutablePointer(to: &data[0]) { dataPointer in
            
            return MIDISysexSendRequest(destination: destination.midiRef,
                                        data: dataPointer,
                                        bytesToSend: byteCount,
                                        complete: false,
                                        reserved: (0,0,0),
                                        completionProc: sendRequestCompletionWrapper,
                                        completionRefCon: Unmanaged.passRetained(self).toOpaque())
        }
        
        let status = MIDISendSysex(&sendRequest)
        
        guard
            status == 0
        else {
            fatalError()
        }
    }
}

fileprivate func sendRequestCompletionWrapper(_ sysexSendRequestPointer: UnsafeMutablePointer<MIDISysexSendRequest>) -> Void {
    
    let sysexSendRequest = sysexSendRequestPointer.pointee
    
    guard
        let unwrappedRawHandler = sysexSendRequest.completionRefCon
    else {
        return
    }
    
    let unmanagedHandler = Unmanaged<SysexMessage>.fromOpaque(unwrappedRawHandler)
    let handler = unmanagedHandler.takeRetainedValue()
    
    handler.handle?(sysexSendRequest)
    handler.sendRequest = nil
    handler.handle = nil
}
