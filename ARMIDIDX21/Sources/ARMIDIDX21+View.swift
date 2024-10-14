//
//  ARMIDIDX21+View.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 10/9/24.
//

import Cocoa

private let kOpBoxTitles: [String] = [
    "Operator 1",
    "Operator 2",
    "Operator 3",
    "Operator 4"
]

private let kOpBoxRowLabels = [
    "Velocity Enabled:",
    "Ampl. Mod. Enabled:",
    "Detune:",
    "Oscillator Frequency:",
    "Output Level:",
    "EG Bias Sensitivity:",
    "Keyboard Scaling Rate:",
    "Keyboard Scaling Level:",
    "Release Rate:",
    "Decay Rate 2:",
    "Decay Level 1:",
    "Decay Rate 1:",
    "Attack Rate:"
]

private let kGrpBoxTitles: [String] = [
    "Low Freq. Osc."
]



private let kGrpBox1RowLabels: [String] =
    [
        "LFO Wave:",
        "LFO Speed:",
        "LFO Delay:",
        "Ampl. Mod. Depth:",
        "Pitch Mod. Depth:",
        "LFO Sync:"
    ]

private let kGrpBoxLeftMargin = 8
private let kGrpBoxRightMargin = 8
private let kGrpBoxHorizontalSpacing = 8
private let kGrpBoxWidth = 224
private let kGrpBoxYPos = 8
private let kGrpBoxHeight = kOpBoxRowHeightWithBuffer * 6 + 10

private let kOpBoxRowHeightWithBuffer = 26
private let kOpBoxLeftMargin = 8
private let kOpBoxRightMargin = 8
private let kOpBoxHorizontalSpacing = 8
private let kOpBoxWidth = 224
private let kOpBoxYPos = kGrpBoxHeight + 10
private let kOpBoxHeight = kOpBoxRowHeightWithBuffer * 13 + 10

private let kOpBox1XPos = kOpBoxLeftMargin
private let kOpBox2XPos = kOpBoxLeftMargin + kOpBoxWidth + kOpBoxHorizontalSpacing
private let kOpBox3XPos = kOpBoxLeftMargin + kOpBoxWidth * 2 + kOpBoxHorizontalSpacing * 2
private let kOpBox4XPos = kOpBoxLeftMargin + kOpBoxWidth * 3 + kOpBoxHorizontalSpacing * 3


private let kGrpBox1XPos = kOpBox1XPos
private let kGrpBox2XPos = kOpBox2XPos
private let kGrpBox3XPos = kOpBox3XPos
private let kGrpBox4XPos = kOpBox4XPos
private let kGrpBox5XPos = kGrpBox4XPos + kOpBoxHorizontalSpacing

private let kDX21ViewHeight = kOpBoxHeight + kGrpBoxHeight + 38
private let kDX21ViewWidth = kOpBoxLeftMargin + kOpBoxWidth * 5 + kOpBoxHorizontalSpacing * 4 + kOpBoxRightMargin

public class DX21View: NSView {
    
    public weak var controller: DX21ViewController? = nil
    
    public func setup(controller: DX21ViewController) -> DX21View {
        self.frame = NSRect(origin: .zero, size: CGSize(width: kDX21ViewWidth, height: kDX21ViewHeight))
        self.controller = controller
        return self.addOpBoxes().addGrpBoxes()
    }
}

extension DX21View {
    
    var kGrpBox1Controls: [NSView?] {
        [
            self.controller?.LFOWave,
            self.controller?.LFOSpeed,
            self.controller?.LFODelay,
            self.controller?.amplitudeModDepth,
            self.controller?.pitchModDepth,
            self.controller?.LFOSync
        ]
    }
    
    func addGrpBoxes() -> DX21View {
            
        let grpBox1 = NSBox(frame: NSRect(x: kGrpBox1XPos, y: kGrpBoxYPos, width: kGrpBoxWidth, height: kGrpBoxHeight)).addBoxRows(controls: kGrpBox1Controls, labels: kGrpBox1RowLabels)
        
            grpBox1.title = kGrpBoxTitles[0]
        
        self.subviews.append(grpBox1)
        
        return self
    }
    
}

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
                guard let control = controls[rowIndex] as? NSTextField else { fatalError() }
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

extension DX21View {
    
    var kOpBox1Controls: [NSView?] {
        [
            self.controller?.op1KeyVelocity,
            self.controller?.op1AmplitudModEnable,
            self.controller?.op1Detune,
            self.controller?.op1OscillatorFrequency,
            self.controller?.op1OutputLevel,
            self.controller?.op1EGBiasSensitivity,
            self.controller?.op1KeyboardScalingRate,
            self.controller?.op1KeyboardScalingLevel,
            self.controller?.op1ReleaseRate,
            self.controller?.op1DecayRate2,
            self.controller?.op1DecayLevel1,
            self.controller?.op1DecayRate1,
            self.controller?.op1AttackRate
        ]
    }
    
    var kOpBox2Controls: [NSView?] {
        [
            self.controller?.op2KeyVelocity,
            self.controller?.op2AmplitudModEnable,
            self.controller?.op2Detune,
            self.controller?.op2OscillatorFrequency,
            self.controller?.op2OutputLevel,
            self.controller?.op2EGBiasSensitivity,
            self.controller?.op2KeyboardScalingRate,
            self.controller?.op2KeyboardScalingLevel,
            self.controller?.op2ReleaseRate,
            self.controller?.op2DecayRate2,
            self.controller?.op2DecayLevel1,
            self.controller?.op2DecayRate1,
            self.controller?.op2AttackRate
        ]
    }
    
    var kOpBox3Controls: [NSView?] {
        [
            self.controller?.op3KeyVelocity,
            self.controller?.op3AmplitudModEnable,
            self.controller?.op3Detune,
            self.controller?.op3OscillatorFrequency,
            self.controller?.op3OutputLevel,
            self.controller?.op3EGBiasSensitivity,
            self.controller?.op3KeyboardScalingRate,
            self.controller?.op3KeyboardScalingLevel,
            self.controller?.op3ReleaseRate,
            self.controller?.op3DecayRate2,
            self.controller?.op3DecayLevel1,
            self.controller?.op3DecayRate1,
            self.controller?.op3AttackRate
        ]
    }
    
    var kOpBox4Controls: [NSView?] {
        [
            self.controller?.op4KeyVelocity,
            self.controller?.op4AmplitudModEnable,
            self.controller?.op4Detune,
            self.controller?.op4OscillatorFrequency,
            self.controller?.op4OutputLevel,
            self.controller?.op4EGBiasSensitivity,
            self.controller?.op4KeyboardScalingRate,
            self.controller?.op4KeyboardScalingLevel,
            self.controller?.op4ReleaseRate,
            self.controller?.op4DecayRate2,
            self.controller?.op4DecayLevel1,
            self.controller?.op4DecayRate1,
            self.controller?.op4AttackRate
        ]
    }
    
    public func addOpBoxes() -> DX21View {
        
        let opBox1 = NSBox(frame: NSRect(x: kOpBox1XPos, y: kOpBoxYPos, width: kOpBoxWidth, height: kOpBoxHeight)).addBoxRows(controls: kOpBox1Controls, labels: kOpBoxRowLabels)
        opBox1.title = kOpBoxTitles[0]
        
        let opBox2 = NSBox(frame: NSRect(x: kOpBox2XPos, y: kOpBoxYPos, width: kOpBoxWidth, height: kOpBoxHeight)).addBoxRows(controls: kOpBox2Controls, labels: kOpBoxRowLabels)
        opBox2.title = kOpBoxTitles[1]
        
        let opBox3 = NSBox(frame: NSRect(x: kOpBox3XPos, y: kOpBoxYPos, width: kOpBoxWidth, height: kOpBoxHeight)).addBoxRows(controls: kOpBox3Controls, labels: kOpBoxRowLabels)
        opBox3.title = kOpBoxTitles[2]
        
        let opBox4 = NSBox(frame: NSRect(x: kOpBox4XPos, y: kOpBoxYPos, width: kOpBoxWidth, height: kOpBoxHeight)).addBoxRows(controls: kOpBox4Controls, labels: kOpBoxRowLabels)
        opBox4.title = kOpBoxTitles[3]
        
        self.subviews.append(contentsOf: [opBox1, opBox2, opBox3, opBox4])
        
        return self
    }
}

extension NSBox {
    
    func addOpBoxRows(controls: [NSView?]) -> NSBox {
        
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
            
            let label = NSTextField(labelWithString: kOpBoxRowLabels[rowIndex])
            label.frame = NSRect(x: kLabelXPos, y: kLabelYPos, width: kLabelWidth, height: kLabelHeight)
            label.alignment = .right
            
            switch rowIndex {
                
            case 0, 1:
                guard let control = controls[rowIndex] as? NSButton else { fatalError() }
                control.frame = NSRect(x: kCheckboxXPos, y: kCheckboxYPos, width: kCheckboxWidth, height: kCheckboxHeight)
                control.setButtonType(.switch)
                control.state = .on
                
                rowView.subviews = [label, control]
                
            default:
                guard let control = controls[rowIndex] as? NSTextField else { fatalError() }
                control.frame = NSRect(x: kInputFieldXPos, y: kInputFieldYPos, width: kInputFieldWidth, height: kInputFieldHeight)
                control.alignment = .right
                
                let stepper = NSStepper(frame: NSRect(x: kStepperXPos, y: kStepperYPos, width: kStepperWidth, height: kStepperHeight))
                
                rowView.subviews = [label, control, stepper]
            }
            
            self.addSubview(rowView)
        }
        
        return self
    }
}
