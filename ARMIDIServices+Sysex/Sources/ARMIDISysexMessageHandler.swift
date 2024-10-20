//
//  ARMIDISysexMessageHandler.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 10/19/24.
//

import CoreMIDI

public protocol ARMIDISysexMessageHandler {
    func handle(sysexMessage: MIDISysexSendRequest)
}
