//
//  ARMIDIError.swift
//  ARMIDI/ARMIDIError/Sources/ARMIDIError.swift
//
//  Created by Aaron Rasmussen on 9/18/24.
//

import CoreMIDI

public enum ARMIDIError: Error, CustomStringConvertible {
    case invalidClient
    case invalidPort
    case wrongEndpointType
    case noConnection
    case unknownEndpoint
    case unknownProperty
    case wrongPropertyType
    case noCurrentSetup
    case messageSendError
    case serverStartError
    case setupFormatError
    case wrongThread
    case objectNotFound
    case IDNotUnique
    case notPermitted
    case unknownError
    case undefined(OSStatus)
    
    init(_ status: OSStatus) {
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
                return "Error: Unknown error (OSStatus (\(status): '\(fourCharCode)')"
            }
        }
    }
}
