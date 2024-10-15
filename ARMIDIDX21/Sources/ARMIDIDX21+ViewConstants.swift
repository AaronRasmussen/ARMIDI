//
//  ARMIDIDX21+ViewConstants.swift
//  Pods
//
//  Created by Aaron Rasmussen on 10/14/24.
//

let kWindowLeftMargin = 8
let kWindowRightMargin = 8
let kWindowBottomMargin = 8

let kWindowItemSpacing = 8

let kBoxWidth = 224

let kBoxColumn1XPos = kWindowLeftMargin
let kBoxColumn2XPos = kBoxColumn1XPos + kBoxWidth + kWindowItemSpacing
let kBoxColumn3XPos = kBoxColumn2XPos + kBoxWidth + kWindowItemSpacing
let kBoxColumn4XPos = kBoxColumn3XPos + kBoxWidth + kWindowItemSpacing
let kBoxColumn5XPos = kBoxColumn4XPos + kBoxWidth + kWindowItemSpacing

let kBoxRowHeight = 24
let kBoxTopMargin = 32
let kGrpBoxHeight = kBoxRowHeight * 6 + kBoxTopMargin
let kOpBoxHeight = kBoxRowHeight * 13 + kBoxTopMargin
let kBoxVerticalSpacing = 16

let kGrpBoxYPos = kWindowBottomMargin
let kGrpBox5YPos = kOpBoxHeight + kBoxVerticalSpacing
let kOpBoxYPos = kGrpBoxHeight + kBoxVerticalSpacing

let kDX21ViewHeight = kWindowBottomMargin + kGrpBoxHeight + kBoxVerticalSpacing + kOpBoxHeight
let kDX21ViewWidth = kWindowLeftMargin + kBoxWidth * 5 + kWindowItemSpacing * 4 + kWindowRightMargin

let kOpBoxTitles: [String] = [
    "Operator 1",
    "Operator 2",
    "Operator 3",
    "Operator 4"
]

let kOpBoxRowLabels = [
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
}

let kGrpBoxTitles: [String] = [
    "Low Freq. Osc.",
    "Br. Ctl. / Mod. Wheel",
    "Pitch / Portamento / Pedals",
    "Miscellaneous",
    "Pitch Envelope Generator"
]

let kGrpBox1RowLabels: [String] =
    [
        "LFO Sync:",
        "Pitch Mod. Depth:",
        "Ampl. Mod. Depth:",
        "LFO Delay:",
        "LFO Speed:",
        "LFO Wave:"
    ]

extension DX21View {
    
    var kGrpBox1Controls: [NSView?] {
        [
            self.controller?.LFOSync,
            self.controller?.pitchModDepth,
            self.controller?.amplitudeModDepth,
            self.controller?.LFODelay,
            self.controller?.LFOSpeed,
            self.controller?.LFOWave
        ]
    }
}

let kGrpBox2RowLabels: [String] =
    [
        "Br.Ctl. EG Bias Range:",
        "Br.Ctl. Pitch Bias Range:",
        "Br.Ctl. Pitch Mod. Range:",
        "Br.Ctl. Ampl. Mod. Range:",
        "M.W. Pitch Mod. Range:",
        "M.W. Ampl. Mod. Range:"
    ]

extension DX21View {
    
    var kGrpBox2Controls: [NSView?] {
        [
            self.controller?.breathControlEGBiasRange,
            self.controller?.breathControlPitchBiasRange,
            self.controller?.breathControlPitchModRange,
            self.controller?.breathControlAmplitudeModRange,
            self.controller?.modWheelPitchModRange,
            self.controller?.modWheelAmplitudeModRange
        ]
    }
}

let kGrpBox3RowLabels: [String] =
    [
        "Volume Pedal:",
        "Sustain Pedal:",
        "Portamento Pedal:",
        "Portamento Speed:",
        "Portamento Time:",
        "Pitch Bend Wheel Range:"
    ]

extension DX21View {
    
    var kGrpBox3Controls: [NSView?] {
        [
            self.controller?.footVolume,
            self.controller?.sustainFootSwitch,
            self.controller?.portamentoFootSwitch,
            self.controller?.portamentoTime,
            self.controller?.portamentoMode,
            self.controller?.pitchBendRange
        ]
    }
}

let kGrpBox4RowLabels: [String] =
    [
        "Transpose:",
        "Feedback Level:",
        "Ampl. Mod. Sensitivity:",
        "Pitch Mod. Sensitivity:",
        "Poly/Mono Play Mode:",
        "Chorus:"
    ]

extension DX21View {
    
    var kGrpBox4Controls: [NSView?] {
        [
            self.controller?.transpose,
            self.controller?.feedbackLevel,
            self.controller?.amplitudeModSensitivity,
            self.controller?.pitchModSensitivity,
            self.controller?.polyOrMonoPlayMode,
            self.controller?.chorusSwitch
        ]
    }
}

let kGrpBox5RowLabels: [String] =
    [
        "Pitch EG Level 3:",
        "Pitch EG Rate 3:",
        "Pitch EG Level 2:",
        "Pitch EG Rate 2:",
        "Pitch EG Level 1:",
        "Pitch EG Rate 1:"
    ]

extension DX21View {
    
    var kGrpBox5Controls: [NSView?] {
        [
            self.controller?.pitchEGLevel3,
            self.controller?.pitchEGRate3,
            self.controller?.pitchEGLevel2,
            self.controller?.pitchEGRate2,
            self.controller?.pitchEGLevel1,
            self.controller?.pitchEGRate1
        ]
    }
}
