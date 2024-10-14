//
//  ARMIDIDX21+Window.swift
//  Pods
//
//  Created by Aaron Rasmussen on 10/12/24.
//

import Cocoa

public class DX21Window: NSWindow {
    
    var vc = DX21ViewController()
    
    public init() {
        let mask: NSWindow.StyleMask = [.closable, .titled, .fullSizeContentView]
        super.init(contentRect: NSRect(origin: CGPoint(x: 240, y: 180), size: .zero), styleMask: mask, backing: .buffered, defer: false)
        self.contentViewController = vc
    }
}
