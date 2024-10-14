//
//  ARMIDIDX21+ViewController.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 10/11/24.
//

import Cocoa

public class DX21ViewController: NSViewController {
    
    public var op1AttackRate = NSTextField()
    public var op1DecayRate1 = NSTextField()
    public var op1DecayRate2 = NSTextField()
    public var op1ReleaseRate = NSTextField()
    public var op1DecayLevel1 = NSTextField()
    public var op1KeyboardScalingLevel = NSTextField()
    public var op1KeyboardScalingRate = NSTextField()
    public var op1EGBiasSensitivity = NSTextField()
    public var op1AmplitudModEnable = NSButton()
    public var op1KeyVelocity = NSButton()
    public var op1OutputLevel = NSTextField()
    public var op1OscillatorFrequency = NSTextField()
    public var op1Detune = NSTextField()

    public var op2AttackRate = NSTextField()
    public var op2DecayRate1 = NSTextField()
    public var op2DecayRate2 = NSTextField()
    public var op2ReleaseRate = NSTextField()
    public var op2DecayLevel1 = NSTextField()
    public var op2KeyboardScalingLevel = NSTextField()
    public var op2KeyboardScalingRate = NSTextField()
    public var op2EGBiasSensitivity = NSTextField()
    public var op2AmplitudModEnable = NSButton()
    public var op2KeyVelocity = NSButton()
    public var op2OutputLevel = NSTextField()
    public var op2OscillatorFrequency = NSTextField()
    public var op2Detune = NSTextField()
    
    public var op3AttackRate = NSTextField()
    public var op3DecayRate1 = NSTextField()
    public var op3DecayRate2 = NSTextField()
    public var op3ReleaseRate = NSTextField()
    public var op3DecayLevel1 = NSTextField()
    public var op3KeyboardScalingLevel = NSTextField()
    public var op3KeyboardScalingRate = NSTextField()
    public var op3EGBiasSensitivity = NSTextField()
    public var op3AmplitudModEnable = NSButton()
    public var op3KeyVelocity = NSButton()
    public var op3OutputLevel = NSTextField()
    public var op3OscillatorFrequency = NSTextField()
    public var op3Detune = NSTextField()
    
    public var op4AttackRate = NSTextField()
    public var op4DecayRate1 = NSTextField()
    public var op4DecayRate2 = NSTextField()
    public var op4ReleaseRate = NSTextField()
    public var op4DecayLevel1 = NSTextField()
    public var op4KeyboardScalingLevel = NSTextField()
    public var op4KeyboardScalingRate = NSTextField()
    public var op4EGBiasSensitivity = NSTextField()
    public var op4AmplitudModEnable = NSButton()
    public var op4KeyVelocity = NSButton()
    public var op4OutputLevel = NSTextField()
    public var op4OscillatorFrequency = NSTextField()
    public var op4Detune = NSTextField()
    
    public var algorithm = NSTextField()
    public var feedbackLevel = NSTextField()
    public var LFOSpeed = NSTextField()
    public var LFODelay = NSTextField()
    public var pitchModDepth = NSTextField()
    public var amplitudeModDepth = NSTextField()
    public var LFOSync = NSButton()
    public var LFOWave = NSTextField()
    public var pitchModSensitivity = NSTextField()
    public var amplitudeModSensitivity = NSTextField()
    public var transpose = NSTextField()
    public var polyOrMonoPlayMode = NSTextField()
    public var pitchBendRange = NSTextField()
    public var portamentoMode = NSTextField()
    public var portamentoTime = NSTextField()
    public var footVolume = NSTextField()
    public var sustainFootSwitch = NSTextField()
    public var portamentoFootSwitch = NSTextField()
    public var chorusSwitch = NSTextField()
    public var modWheelPitchModRange = NSTextField()
    public var modWheelAmplitudeModRange = NSTextField()
    public var breathControlPitchModRange = NSTextField()
    public var breathControlAmplitudeModRange = NSTextField()
    public var breathControlPitchBiasRange = NSTextField()
    public var breathControlEGBiasRange = NSTextField()
    public var pitchEGRate1 = NSTextField()
    public var pitchEGRate2 = NSTextField()
    public var pitchEGRate3 = NSTextField()
    public var pitchEGLevel1 = NSTextField()
    public var pitchEGLevel2 = NSTextField()
    public var pitchEGLevel3 = NSTextField()
    
    public var voiceName = NSTextField()
    
    public var voiceControls: [NSView?] {
        
        [
            op1AttackRate,
            op1DecayRate1,
            op1DecayRate2,
            op1ReleaseRate,
            op1DecayLevel1,
            op1KeyboardScalingLevel,
            op1KeyboardScalingRate,
            op1EGBiasSensitivity,
            op1AmplitudModEnable,
            op1KeyVelocity,
            op1OutputLevel,
            op1OscillatorFrequency,
            op1Detune,
            
            op2AttackRate,
            op2DecayRate1,
            op2DecayRate2,
            op2ReleaseRate,
            op2DecayLevel1,
            op2KeyboardScalingLevel,
            op2KeyboardScalingRate,
            op2EGBiasSensitivity,
            op2AmplitudModEnable,
            op2KeyVelocity,
            op2OutputLevel,
            op2OscillatorFrequency,
            op2Detune,
            
            op3AttackRate,
            op3DecayRate1,
            op3DecayRate2,
            op3ReleaseRate,
            op3DecayLevel1,
            op3KeyboardScalingLevel,
            op3KeyboardScalingRate,
            op3EGBiasSensitivity,
            op3AmplitudModEnable,
            op3KeyVelocity,
            op3OutputLevel,
            op3OscillatorFrequency,
            op3Detune,
            
            op4AttackRate,
            op4DecayRate1,
            op4DecayRate2,
            op4ReleaseRate,
            op4DecayLevel1,
            op4KeyboardScalingLevel,
            op4KeyboardScalingRate,
            op4EGBiasSensitivity,
            op4AmplitudModEnable,
            op4KeyVelocity,
            op4OutputLevel,
            op4OscillatorFrequency,
            op4Detune,
            
            algorithm,
            feedbackLevel,
            LFOSpeed,
            LFODelay,
            pitchModDepth,
            amplitudeModDepth,
            LFOSync,
            LFOWave,
            pitchModSensitivity,
            amplitudeModSensitivity,
            transpose,
            polyOrMonoPlayMode,
            pitchBendRange,
            portamentoMode,
            portamentoTime,
            footVolume,
            sustainFootSwitch,
            portamentoFootSwitch,
            chorusSwitch,
            modWheelPitchModRange,
            modWheelAmplitudeModRange,
            breathControlPitchModRange,
            breathControlAmplitudeModRange,
            breathControlPitchBiasRange,
            breathControlEGBiasRange,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            nil,
            pitchEGRate1,
            pitchEGRate2,
            pitchEGRate3,
            pitchEGLevel1,
            pitchEGLevel2,
            pitchEGLevel3
        ]
    }
    
    let voice = DX21Voice()
    
    public override func loadView() {
        
        self.view = DX21View().setup(controller: self)
        
        let _ = (0..<voiceControls.count).map { index in
            
            switch voiceControls[index] {
                
            case let c as NSTextField:
                c.integerValue = Int(voice.data[index])
                
            case let c as NSButton:
                c.state = voice.data[index] != 0 ? .on : .off
                
            default:
                return
            }
        }
    }
}
