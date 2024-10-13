//
//  ARMIDIDX21+ViewController.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 10/11/24.
//

import Cocoa

public class DX21ViewController: NSViewController {
    
    public override func loadView() {
        self.view = DX21View(frame: .init(x: 200, y: 120, width: 808, height: 600)).setup()
    }
}
