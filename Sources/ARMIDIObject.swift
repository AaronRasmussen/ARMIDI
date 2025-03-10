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
}

extension ObjectReferable {
    
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
    
    public func getIntegerProeprty(_ property: CFString) throws -> Int32 {
        
        var integer = Int32(0)
        let status = MIDIObjectGetIntegerProperty(self.midiRef, property, &integer)
        
        guard
            status == 0
        else{
            throw MIDIError(status)
        }
        
        return integer
    }
}
