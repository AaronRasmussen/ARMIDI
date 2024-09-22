//
//  ARMIDIServices.swift
//  ARMIDI/ARMIDIServices/Sources/ARMIDIServices.swift
//
//  Created by Aaron Rasmussen on 9/19/24.
//

import CoreMIDI

public func restart() throws {
    let status = MIDIRestart()
    guard status == 0 else { throw ARMIDIError(status) }
    return
}
