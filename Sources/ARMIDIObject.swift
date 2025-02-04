//
//  ARMIDIObject.swift
//  
//
//  Created by Aaron Rasmussen on 2/3/25.
//

import CoreMIDI
import ARMIDIError

extension MIDIObjectRef: ObjectReferable {
    
    public var midiRef: UInt32 {
        get {
            return self
        }
    }
    
    public func getStringProperty(_ property: CFString) throws -> String? {
        
        var stringProperty: Unmanaged<CFString>? = nil
        
        let status = MIDIObjectGetStringProperty(self.midiRef, property, &stringProperty)
        
        guard
            status != kMIDIUnknownProperty
        else { return nil }
        
        guard
            status == 0
        else {
            throw MIDIError(status)
        }
        
        return stringProperty?.takeUnretainedValue() as String?
    }
}
