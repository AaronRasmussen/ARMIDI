//
//  ARMIDIDX21+NSBoxExtension.swift
//  Pods
//
//  Created by Aaron Rasmussen on 10/14/24.
//

import Cocoa

extension NSBox {
    
    func addBoxRows(controls: [NSView?], labels: [String]) -> NSBox {
        
        let kRowHeight = 24
        let kElementSpacing = 4
        
        let kLabelWidth = 152
        let kLabelHeight = kRowHeight - 4
        let kLabelXPos = 0
        let kLabelYPos = 0
        
        let kInputFieldWidth = 32
        let kInputFieldHeight = kRowHeight
        let kInputFieldXPos = kLabelWidth + kElementSpacing
        let kInputFieldYPos = 0
        
        let kStepperWidth = 18
        let kStepperHeight = kRowHeight
        let kStepperXPos = kInputFieldXPos + kInputFieldWidth + kElementSpacing
        let kStepperYPos = 0
        
        let kCheckboxWidth = 18
        let kCheckboxHeight = kRowHeight
        let kCheckboxXPos = kInputFieldXPos
        let kCheckboxYPos = 0
        
        let _ = (0..<controls.count).map { rowIndex in
            
            let yPos = kRowHeight * rowIndex
            let rowView = NSView(frame: NSRect(x: 0, y: yPos, width: Int(self.frame.width) - 10, height: kRowHeight))
            
            let label = NSTextField(labelWithString: labels[rowIndex])
            label.frame = NSRect(x: kLabelXPos, y: kLabelYPos, width: kLabelWidth, height: kLabelHeight)
            label.alignment = .right
            
            switch controls[rowIndex] {
                
            case let c as NSButton:
                c.frame = NSRect(x: kCheckboxXPos, y: kCheckboxYPos, width: kCheckboxWidth, height: kCheckboxHeight)
                c.setButtonType(.switch)
                c.state = .on
                
                rowView.subviews = [label, c]
                
            case let c as NSTextField:
                c.frame = NSRect(x: kInputFieldXPos, y: kInputFieldYPos, width: kInputFieldWidth, height: kInputFieldHeight)
                c.alignment = .right
                
                let stepper = NSStepper(frame: NSRect(x: kStepperXPos, y: kStepperYPos, width: kStepperWidth, height: kStepperHeight))
                
                rowView.subviews = [label, c, stepper]
                
            default:
                fatalError()
            }
            
            self.addSubview(rowView)
        }
        
        return self
    }
}
