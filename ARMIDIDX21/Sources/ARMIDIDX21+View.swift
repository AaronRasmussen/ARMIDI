//
//  ARMIDIDX21+View.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 10/9/24.
//

import Cocoa

public class DX21View: NSView {
    
    public weak var controller: DX21ViewController? = nil
    
    public func setup(controller: DX21ViewController) -> DX21View {
        self.frame = NSRect(origin: .zero, size: CGSize(width: kDX21ViewWidth, height: kDX21ViewHeight))
        self.controller = controller
        return self.addOpBoxes().addGrpBoxes()
    }
    
    func addGrpBoxes() -> DX21View {
            
        let grpBox1 = NSBox(frame: NSRect(x: kBoxColumn1XPos, y: kGrpBoxYPos, width: kBoxWidth, height: kGrpBoxHeight)).addBoxRows(controls: kGrpBox1Controls, labels: kGrpBox1RowLabels)
        
            grpBox1.title = kGrpBoxTitles[0]
        
        let grpBox2 = NSBox(frame: NSRect(x: kBoxColumn2XPos, y: kGrpBoxYPos, width: kBoxWidth, height: kGrpBoxHeight)).addBoxRows(controls: kGrpBox2Controls, labels: kGrpBox2RowLabels)
        
            grpBox2.title = kGrpBoxTitles[1]
        
        let grpBox3 = NSBox(frame: NSRect(x: kBoxColumn3XPos, y: kGrpBoxYPos, width: kBoxWidth, height: kGrpBoxHeight)).addBoxRows(controls: kGrpBox3Controls, labels: kGrpBox3RowLabels)
        
            grpBox3.title = kGrpBoxTitles[2]
        
        let grpBox4 = NSBox(frame: NSRect(x: kBoxColumn4XPos, y: kGrpBoxYPos, width: kBoxWidth, height: kGrpBoxHeight)).addBoxRows(controls: kGrpBox4Controls, labels: kGrpBox4RowLabels)
        
            grpBox4.title = kGrpBoxTitles[3]
        
        let grpBox5 = NSBox(frame: NSRect(x: kBoxColumn5XPos, y: kGrpBox5YPos, width: kBoxWidth, height: kGrpBoxHeight)).addBoxRows(controls: kGrpBox5Controls, labels: kGrpBox5RowLabels)
        
            grpBox5.title = kGrpBoxTitles[4]
        
        self.subviews.append(contentsOf: [grpBox1, grpBox2, grpBox3, grpBox4, grpBox5])
        
        return self
    }
    
    public func addOpBoxes() -> DX21View {
        
        let opBox1 = NSBox(frame: NSRect(x: kBoxColumn1XPos, y: kOpBoxYPos, width: kBoxWidth, height: kOpBoxHeight)).addBoxRows(controls: kOpBox1Controls, labels: kOpBoxRowLabels)
        
        opBox1.title = kOpBoxTitles[0]
        
        let opBox2 = NSBox(frame: NSRect(x: kBoxColumn2XPos, y: kOpBoxYPos, width: kBoxWidth, height: kOpBoxHeight)).addBoxRows(controls: kOpBox2Controls, labels: kOpBoxRowLabels)
        
        opBox2.title = kOpBoxTitles[1]
        
        let opBox3 = NSBox(frame: NSRect(x: kBoxColumn3XPos, y: kOpBoxYPos, width: kBoxWidth, height: kOpBoxHeight)).addBoxRows(controls: kOpBox3Controls, labels: kOpBoxRowLabels)
        
        opBox3.title = kOpBoxTitles[2]
        
        let opBox4 = NSBox(frame: NSRect(x: kBoxColumn4XPos, y: kOpBoxYPos, width: kBoxWidth, height: kOpBoxHeight)).addBoxRows(controls: kOpBox4Controls, labels: kOpBoxRowLabels)
        
        opBox4.title = kOpBoxTitles[3]
        
        self.subviews.append(contentsOf: [opBox1, opBox2, opBox3, opBox4])
        
        return self
    }
}

