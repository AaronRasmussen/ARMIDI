//
//  ARMIDIServices+Endpoints.swift
//  Pods
//
//  Created by Aaron Rasmussen on 9/22/24.
//

import CoreMIDI

public func numberOfSources() -> Int {
    return MIDIGetNumberOfSources()
}

public func source(atIndex i: Int) -> MIDIEndpointRef {
    return MIDIGetSource(i)
}

public func sources() -> [MIDIEndpointRef] {
    return (0..<numberOfSources()).map {
        source(atIndex: $0)
    }
}

public func numberOfDestinations() -> Int {
    return MIDIGetNumberOfDestinations()
}

public func destination(atIndex i: Int) -> MIDIEndpointRef {
    return MIDIGetDevice(i)
}

public func destinations() -> [MIDIEndpointRef] {
    return (0..<numberOfDestinations()).map {
        destination(atIndex: $0)
    }
}

public func entity(forEndpoint e: MIDIEndpointRef) throws -> MIDIEntityRef {
    var entity: MIDIEntityRef = 0
    let status = MIDIEndpointGetEntity(e, &entity)
    guard status == 0 else { throw ARMIDIError(status) }
    return entity
}
    
public func flushOutput(forEndpoint e: MIDIEndpointRef) throws {
    let status = MIDIFlushOutput(e)
    guard status == 0 else { throw ARMIDIError(status) }
}

public func dispose(ofEndpoint e: MIDIEndpointRef) throws {
    let status = MIDIEndpointDispose(e)
    guard status == 0 else { throw ARMIDIError(status) }
}
    
    // public func getRefConsForEndpoint( UNDEFINED )
    // puboic func setRefConsForEndpoint( UNDEFINED )
