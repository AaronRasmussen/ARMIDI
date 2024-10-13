//
//  ARMIDIDX21+View.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 10/9/24.
//

import Cocoa

public class DX21View: NSView {
    
    public func setup() -> DX21View {
        self.addOpBoxes()
        return self
    }
}
                            
extension DX21View {
    
    public func addOpBoxes() {
        let opBoxes: [(title: String, xPos: Int)] = [
            (title: "Operator 1", xPos: 8),
            (title: "Operator 2", xPos: 208),
            (title: "Operator 3", xPos: 408),
            (title: "Operator 4", xPos: 608)
        ]
        
        let _ = opBoxes.map {
            let opBox = DX21OpBox(frame: NSRect(x: $0.xPos, y: 180, width: 192, height: 300))
            opBox.title = $0.title
            return self.addSubview(opBox)
        }
    }
}

public class DX21OpBox: NSBox {
    
}
