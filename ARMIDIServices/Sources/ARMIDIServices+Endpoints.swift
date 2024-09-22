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

public func sourceAtIndex(_ index: Int) -> MIDIEndpointRef {
    return MIDIGetSource(index)
}

public func sources() -> [MIDIEndpointRef] {
    return (0..<numberOfSources()).map {
        sourceAtIndex($0)
    }
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

public func entityForEndpoint(_ endpoint: MIDIEndpointRef) throws -> MIDIEntityRef {
    var entity: MIDIEntityRef = 0
    let status = MIDIEndpointGetEntity(endpoint, &entity)
    guard status == 0 else { throw ARMIDIError(status) }
    return entity
}
    
public func flushOutputForEndpoint (_ endpoint: MIDIEndpointRef) throws {
    let status = MIDIFlushOutput(endpoint)
    guard status == 0 else { throw ARMIDIError(status) }
    return
}

public func disposeOfEndpoint(_ endpointRef: MIDIEndpointRef) throws {
    let status = MIDIEndpointDispose(endpointRef)
    guard status == 0 else { throw ARMIDIError(status) }
    return
    
    // public func getRefConsForEndpoint( UNDEFINED )
    // puboic func setRefConsForEndpoint( UNDEFINED )
}
