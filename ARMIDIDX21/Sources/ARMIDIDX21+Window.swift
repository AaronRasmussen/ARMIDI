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
        let rect = CGRect(x: 200, y: 120, width: 808, height: 600)
        let mask: NSWindow.StyleMask = [.closable, .titled, .fullSizeContentView]
        super.init(contentRect: rect, styleMask: mask, backing: .buffered, defer: false)
        self.contentViewController = vc
    }
}
