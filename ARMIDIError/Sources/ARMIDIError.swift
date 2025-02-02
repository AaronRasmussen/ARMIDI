//
//  ARMIDIError.swift
//  ARMIDI/ARMIDIError/Sources/ARMIDIError.swift
//
//  Created by Aaron Rasmussen on 9/18/24.
//

import CoreMIDI

/// An `Error` type based on the `OSStatus` error codes defined by `CoreMIDI`.
public enum ARMIDIError: Error, CustomStringConvertible {
    
    /// The client is invalid.
    ///
    /// `OSStatus kMIDIInvalidClient` (`-10830`)
    case invalidClient
    
    /// The port is invalid.
    ///
    /// `OSStatus kMIDIInvalidPort` (`-10831`)
    case invalidPort
    
    /// A function received a source endpoint when it required a destination endpoint, or vice versa.
    ///
    /// `OSStatus kMIDIWrongEndpointType` (`-10832`)
    case wrongEndpointType
    
    /// The connection you’re trying to close doesn’t exist.
    ///
    /// `OSStatus kMIDINoConnection` (`-10833`)
    case noConnection
    
    /// The system doesn’t recognize the endpoint.
    ///
    /// `OSStatus kMIDIUnknownEndpoint` (`-10834`)
    case unknownEndpoint
    
    /// Attempt to query a property not set on the object.
    ///
    /// `OSStatus kMIDIUnknownProperty` (`-10835`)
    case unknownProperty
    
    /// Attempt to set a property with a value not of the correct type.
    ///
    /// `OSStatus kMIDIWrongPropertyType` (`-10836`)
    case wrongPropertyType
    
    /// A MIDI setup object doesn’t currently exist.
    ///
    /// `OSStatus kMIDINoCurrentSetup` (`-10837`)
    case noCurrentSetup
    
    /// The communication with the MIDI server failed.
    ///
    /// `OSStatus kMIDIMessageSendErr` (`-10838`)
    case messageSendError
    
    /// The system can’t start the MIDI server.
    ///
    /// `OSStatus kMIDIServerStartErr` (`-10839`)
    case serverStartError
    
    /// The system can’t read the saved state.
    ///
    /// `OSStatus kMIDISetupFormatErr` (`-10840`)
    case setupFormatError
    
    /// A driver is calling a non-I/O function in the server from a thread other than the server’s main thread.
    ///
    /// `OSStatus kMIDIWrongThread` (`-10841`)
    case wrongThread
    
    /// The requested object doesn’t exist.
    ///
    /// `OSStatus kMIDIObjectNotFound` (`-10842`)
    case objectNotFound
    
    /// The identifier you’re trying to set isn’t unique.
    ///
    /// `OSStatus kMIDIIDNotUnique` (`-10843`)
    case IDNotUnique
    
    /// The process doesn’t have privileges for the requested operation.
    ///
    /// `OSStatus kMIDINotPermitted` (`-10844`)
    case notPermitted
    
    /// The system can’t perform the requested operation.
    ///
    /// `OSStatus kMIDIUnknownError` (`-10845`)
    case unknownError
    
    /// The returned `OSStatus` error code is not defined by CoreMIDI.
    ///
    /// The `OSStatus` error code is stored as a associated value.
    ///
    /// The `description` property for this case includes the `OSStatus` code.
    /// If the error code can be parsed to a four-character ASCII text string, that four-character
    /// string will also be included in the `description`.
    case undefined(OSStatus)
    
    public init(_ status: OSStatus) {
        switch status {
        case kMIDIInvalidClient:
            self = .invalidClient
        case kMIDIInvalidPort:
            self = .invalidPort
        case kMIDIWrongEndpointType:
            self = .wrongEndpointType
        case kMIDINoConnection:
            self = .noConnection
        case kMIDIUnknownEndpoint:
            self = .unknownEndpoint
        case kMIDIUnknownProperty:
            self = .unknownProperty
        case kMIDIWrongPropertyType:
            self = .wrongPropertyType
        case kMIDINoCurrentSetup:
            self = .noCurrentSetup
        case kMIDIMessageSendErr:
            self = .messageSendError
        case kMIDIServerStartErr:
            self = .serverStartError
        case kMIDISetupFormatErr:
            self = .setupFormatError
        case kMIDIWrongThread:
            self = .wrongThread
        case kMIDIObjectNotFound:
            self = .objectNotFound
        case kMIDIIDNotUnique:
            self = .IDNotUnique
        case kMIDINotPermitted:
            self = .notPermitted
        case kMIDIUnknownError:
            self = .unknownError
        default:
            self = .undefined(status)
        }
    }
    
    /// A brief description of the error including the underlying `OSStatus` error code
    public var description: String {
        get {
            switch self {
            case .invalidClient:
                return "Error: The client is invalid (OSStatus \(kMIDIInvalidClient): kMIDIInvalidClient)"
            case .invalidPort:
                return "Error: The port is invalid (OSStatus \(kMIDIInvalidPort): kMIDIInvalidPort)"
            case .wrongEndpointType:
                return "Error: A function received a source endpoint when it required a destination endpoint, or vice versa (OSStatus \(kMIDIWrongEndpointType): kMIDIWrongEndpointType)"
            case .noConnection:
                return "Error: The connection you’re trying to close doesn’t exist (OSStatus \(kMIDINoConnection): kMIDINoConnection)"
            case .unknownEndpoint:
                return "Error: The system doesn’t recognize the endpoint (OSStatus \(kMIDIUnknownEndpoint): kMIDIUnknownEndpoint)"
            case .unknownProperty:
                return "Error: Attempt to query a property not set on the object (OSStatus \(kMIDIUnknownProperty): kMIDIUnknownProperty)"
            case .wrongPropertyType:
                return "Error: Attempt to set a property with a value not of the correct type (OSStatus \(kMIDIWrongPropertyType): kMIDIWrongPropertyType)"
            case .noCurrentSetup:
                return "Error: A MIDI setup object doesn’t currently exist (OSStatus \(kMIDINoCurrentSetup): kMIDINoCurrentSetup)"
            case .messageSendError:
                return "Error: The communication with the MIDI server failed (OSStatus \(kMIDIMessageSendErr): kMIDIMessageSendErr)"
            case .serverStartError:
                return "Error: The system can’t start the MIDI server (OSStatus \(kMIDIServerStartErr): kMIDIServerStartErr)"
            case .setupFormatError:
                return "Error: The system can’t read the saved state (OSStatus \(kMIDISetupFormatErr): kMIDISetupFormatErr)"
            case .wrongThread:
                return "Error: A driver is calling a non-I/O function in the server from a thread other than the server’s main thread (OSStatus \(kMIDIWrongThread): kMIDIWrongThread)"
            case .objectNotFound:
                return "Error: The requested object doesn’t exist (OSStatus \(kMIDIObjectNotFound): kMIDIObjectNotFound)"
            case .IDNotUnique:
                return "Error: The identifier you’re trying to set isn’t unique (OSStatus \(kMIDIIDNotUnique): kMIDIIDNotUnique)"
            case .notPermitted:
                return "Error: The process doesn’t have privileges for the requested operation (OSStatus \(kMIDINotPermitted): kMIDINotPermitted)"
            case .unknownError:
                return "Error: The system can’t perform the requested operation (OSStatus \(kMIDIUnknownError): kMIDIUnknownError)"
            case .undefined(let status):
                guard let fourCharCode = [status].withUnsafeBytes({ statusBytes in
                    return String(data: Data(bytes: statusBytes.reversed(), count: 4), encoding: .utf8)
                }) else {
                    return "Error: Unknown error (OSStatus \(status))"
                }
                return "Error: Unknown error (OSStatus \(status): '\(fourCharCode)')"
            }
        }
    }
}
