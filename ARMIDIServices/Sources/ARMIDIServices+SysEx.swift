//
//  ARMIDIServices+SysEx.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 1/31/25.
//

import CoreMIDI

public struct ParsedSysexUMP {
    public let group: UInt32
    public let status: UInt32
    public let numBytes: UInt32
    public let data: [UInt8]
    
    public init(group: UInt32, status: UInt32, numBytes: UInt32, data: [UInt8]) {
        self.group = group
        self.status = status
        self.numBytes = numBytes
        self.data = data
    }
}

@available(macOS 11.0, *)
public func parseSysexUMP(words: MIDIEventPacket.WordCollection) -> ParsedSysexUMP {
    
    let word64 = (UInt64(words[0]) << 32) | UInt64(words[1])
    
    let group: UInt32       = UInt32(word64 >> 56) & 0xf
    let status: UInt32      = UInt32(word64 >> 52) & 0xf
    let numBytes: UInt32    = UInt32(word64 >> 48) & 0xf
    
    let data: [UInt8] = (0..<numBytes).map { index in
        UInt8(word64 >> (40 - 8 * index) & 0xff)
    }
    
    return ParsedSysexUMP(group: group, status: status, numBytes: numBytes, data: data)
}


// A class that replaces CoreMIDI's MIDISysexSendRequest
public class ARMIDISysexMessage {
    
    //The completion handler
    fileprivate var handle: ((MIDISysexSendRequest) -> Void)?
    private var data: [UInt8] = []
    private var sendRequest: MIDISysexSendRequest!
    private var destination: MIDIEndpointRef
    
    public init(data: [UInt8],
                destination: MIDIEndpointRef,
                completionHandler: ((MIDISysexSendRequest) -> Void)?) {
        
        self.data = data
        self.destination = destination
        self.handle = completionHandler
    }
    
    public func send() throws {
        
        let byteCount: UInt32 = UInt32(self.data.count)
        
        self.sendRequest = withUnsafeMutablePointer(to: &self.data[0]) { dataPointer in
            
            MIDISysexSendRequest(destination: self.destination,
                                 data: dataPointer,
                                 bytesToSend: byteCount,
                                 complete: false,
                                 reserved: (0,0,0),
                                 completionProc: sendRequestCompletionWrapper,
                                 completionRefCon: Unmanaged.passRetained(self).toOpaque())
        }
        
        let status = MIDISendSysex(&self.sendRequest)
        
        guard status == 0 else {
            fatalError()
        }
    }
}

fileprivate func sendRequestCompletionWrapper(_ sysexSendRequestPointer: UnsafeMutablePointer<MIDISysexSendRequest>) -> Void {
    
    let sysexSendRequest = sysexSendRequestPointer.pointee
    
    guard
        let unwrappedRawHandler = sysexSendRequest.completionRefCon
    else { return }
    
    let unmanagedHandler = Unmanaged<ARMIDISysexMessage>.fromOpaque(unwrappedRawHandler)
    let handler = unmanagedHandler.takeRetainedValue()
    
    handler.handle?(sysexSendRequest)
}
