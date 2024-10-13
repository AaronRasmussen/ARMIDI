//
//  ARMIDIDX21+Window.swift
//  Pods
//
//  Created by Aaron Rasmussen on 10/12/24.
//

import Cocoa

public class DX21Window: NSWindow {
    
    public init() {
        let rect = CGRect(x: 200, y: 120, width: 800, height: 600)
        let mask: NSWindow.StyleMask = [.closable, .titled]
        super.init(contentRect: rect, styleMask: mask, backing: .buffered, defer: false)
        self.contentViewController = DX21ViewController()
    }
}
