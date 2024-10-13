//
//  ARMIDIDX21+Voice.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 10/9/24.
//

public class DX21Voice {
    
    public var voiceName: String {
        return String(data: data[kDX21ParamVoiceName0...kDX21ParamVoiceName9], encoding: .utf8) ?? ""
    }
    
    public var op1AttackRate: UInt8
    public var op1DecayRate1: UInt8
    public var op1DecayRate2: UInt8
    public var op1ReleaseRate: UInt8
    public var op1DecayLevel1: UInt8
    public var op1KeyboardScalingLevel: UInt8
    public var op1KeyboardScalingRate: UInt8
    public var op1EGBiasSensitivity: UInt8
    public var op1AmplitudeModEnable: UInt8
    public var op1KeyVelocity: UInt8
    public var op1OutputLevel: UInt8
    public var op1OscillatorFrequency: UInt8
    public var op1Detune: UInt8
    
    public var op2AttackRate: UInt8
    public var op2DecayRate1: UInt8
    public var op2DecayRate2: UInt8
    public var op2ReleaseRate: UInt8
    public var op2DecayLevel1: UInt8
    public var op2KeyboardScalingLevel: UInt8
    public var op2KeyboardScalingRate: UInt8
    public var op2EGBiasSensitivity: UInt8
    public var op2AmplitudeModEnable: UInt8
    public var op2KeyVelocity: UInt8
    public var op2OutputLevel: UInt8
    public var op2OscillatorFrequency: UInt8
    public var op2Detune: UInt8
    
    public var op3AttackRate: UInt8
    public var op3DecayRate1: UInt8
    public var op3DecayRate2: UInt8
    public var op3ReleaseRate: UInt8
    public var op3DecayLevel1: UInt8
    public var op3KeyboardScalingLevel: UInt8
    public var op3KeyboardScalingRate: UInt8
    public var op3EGBiasSensitivity: UInt8
    public var op3AmplitudeModEnable: UInt8
    public var op3KeyVelocity: UInt8
    public var op3OutputLevel: UInt8
    public var op3OscillatorFrequency: UInt8
    public var op3Detune: UInt8
    
    public var op4AttackRate: UInt8
    public var op4DecayRate1: UInt8
    public var op4DecayRate2: UInt8
    public var op4ReleaseRate: UInt8
    public var op4DecayLevel1: UInt8
    public var op4KeyboardScalingLevel: UInt8
    public var op4KeyboardScalingRate: UInt8
    public var op4EGBiasSensitivity: UInt8
    public var op4AmplitudeModEnable: UInt8
    public var op4KeyVelocity: UInt8
    public var op4OutputLevel: UInt8
    public var op4OscillatorFrequency: UInt8
    public var op4Detune: UInt8
    
    public var algorithm: UInt8
    public var feedbackLevel: UInt8
    public var LFOSpeed: UInt8
    public var LFODelay: UInt8
    public var pitchModDepth: UInt8
    public var amplitudeModDepth: UInt8
    public var LFOSync: UInt8
    public var LFOWave: UInt8
    public var pitchModSensitivity: UInt8
    public var amplitudeModSensitivity: UInt8
    public var transpose: UInt8
    public var polyOrMonoPlayMode: UInt8
    public var pitchBendRange: UInt8
    public var portamentoMode: UInt8
    public var portamentoTime: UInt8
    public var footVolume: UInt8
    public var sustainFootSwitch: UInt8
    public var portamentoFootSwitch: UInt8
    public var chorusSwitch: UInt8
    public var modWheelPitchModRange: UInt8
    public var modWheelAmplitudeModRange: UInt8
    public var breathControlPitchModRange: UInt8
    public var breathControlAmplitudeModRange: UInt8
    public var breathControlPitchBiasRange: UInt8
    public var breathControlEGBiasRange: UInt8
    public var voiceName0: UInt8
    public var voiceName1: UInt8
    public var voiceName2: UInt8
    public var voiceName3: UInt8
    public var voiceName4: UInt8
    public var voiceName5: UInt8
    public var voiceName6: UInt8
    public var voiceName7: UInt8
    public var voiceName8: UInt8
    public var voiceName9: UInt8
    public var pitchEGRate1: UInt8
    public var pitchEGRate2: UInt8
    public var pitchEGRate3: UInt8
    public var pitchEGLevel1: UInt8
    public var pitchEGLevel2: UInt8
    public var pitchEGLevel3: UInt8
    
    public var data: Data
    
    public init(singleVoiceData d: Data) {
        
        self.data = d
        
        self.op1AttackRate                  = d[kDX21ParamOp1AttackRate]
        self.op1DecayRate1                  = d[kDX21ParamOp1DecayRate1]
        self.op1DecayRate2                  = d[kDX21ParamOp1DecayRate2]
        self.op1ReleaseRate                 = d[kDX21ParamOp1ReleaseRate]
        self.op1DecayLevel1                 = d[kDX21ParamOp1DecayLevel1]
        self.op1KeyboardScalingLevel        = d[kDX21ParamOp1KeyboardScalingLevel]
        self.op1KeyboardScalingRate         = d[kDX21ParamOp1KeyboardScalingRate]
        self.op1EGBiasSensitivity           = d[kDX21ParamOp1EGBiasSensitivity]
        self.op1AmplitudeModEnable          = d[kDX21ParamOp1AmplitudeModEnable]
        self.op1KeyVelocity                 = d[kDX21ParamOp1KeyVelocity]
        self.op1OutputLevel                 = d[kDX21ParamOp1OutputLevel]
        self.op1OscillatorFrequency         = d[kDX21ParamOp1OscillatorFrequency]
        self.op1Detune                      = d[kDX21ParamOp1Detune]
        
        self.op2AttackRate                  = d[kDX21ParamOp2AttackRate]
        self.op2DecayRate1                  = d[kDX21ParamOp2DecayRate1]
        self.op2DecayRate2                  = d[kDX21ParamOp2DecayRate2]
        self.op2ReleaseRate                 = d[kDX21ParamOp2ReleaseRate]
        self.op2DecayLevel1                 = d[kDX21ParamOp2DecayLevel1]
        self.op2KeyboardScalingLevel        = d[kDX21ParamOp2KeyboardScalingLevel]
        self.op2KeyboardScalingRate         = d[kDX21ParamOp2KeyboardScalingRate]
        self.op2EGBiasSensitivity           = d[kDX21ParamOp2EGBiasSensitivity]
        self.op2AmplitudeModEnable          = d[kDX21ParamOp2AmplitudeModEnable]
        self.op2KeyVelocity                 = d[kDX21ParamOp2KeyVelocity]
        self.op2OutputLevel                 = d[kDX21ParamOp2OutputLevel]
        self.op2OscillatorFrequency         = d[kDX21ParamOp2OscillatorFrequency]
        self.op2Detune                      = d[kDX21ParamOp2Detune]
        
        self.op3AttackRate                  = d[kDX21ParamOp3AttackRate]
        self.op3DecayRate1                  = d[kDX21ParamOp3DecayRate1]
        self.op3DecayRate2                  = d[kDX21ParamOp3DecayRate2]
        self.op3ReleaseRate                 = d[kDX21ParamOp3ReleaseRate]
        self.op3DecayLevel1                 = d[kDX21ParamOp3DecayLevel1]
        self.op3KeyboardScalingLevel        = d[kDX21ParamOp3KeyboardScalingLevel]
        self.op3KeyboardScalingRate         = d[kDX21ParamOp3KeyboardScalingRate]
        self.op3EGBiasSensitivity           = d[kDX21ParamOp3EGBiasSensitivity]
        self.op3AmplitudeModEnable          = d[kDX21ParamOp3AmplitudeModEnable]
        self.op3KeyVelocity                 = d[kDX21ParamOp3KeyVelocity]
        self.op3OutputLevel                 = d[kDX21ParamOp3OutputLevel]
        self.op3OscillatorFrequency         = d[kDX21ParamOp3OscillatorFrequency]
        self.op3Detune                      = d[kDX21ParamOp3Detune]
        
        self.op4AttackRate                  = d[kDX21ParamOp4AttackRate]
        self.op4DecayRate1                  = d[kDX21ParamOp4DecayRate1]
        self.op4DecayRate2                  = d[kDX21ParamOp4DecayRate2]
        self.op4ReleaseRate                 = d[kDX21ParamOp4ReleaseRate]
        self.op4DecayLevel1                 = d[kDX21ParamOp4DecayLevel1]
        self.op4KeyboardScalingLevel        = d[kDX21ParamOp4KeyboardScalingLevel]
        self.op4KeyboardScalingRate         = d[kDX21ParamOp4KeyboardScalingRate]
        self.op4EGBiasSensitivity           = d[kDX21ParamOp4EGBiasSensitivity]
        self.op4AmplitudeModEnable          = d[kDX21ParamOp4AmplitudeModEnable]
        self.op4KeyVelocity                 = d[kDX21ParamOp4KeyVelocity]
        self.op4OutputLevel                 = d[kDX21ParamOp4OutputLevel]
        self.op4OscillatorFrequency         = d[kDX21ParamOp4OscillatorFrequency]
        self.op4Detune                      = d[kDX21ParamOp4Detune]
    
        self.algorithm                      = d[kDX21ParamAlgorithm]
        self.feedbackLevel                  = d[kDX21ParamFeedbackLevel]
        self.LFOSpeed                       = d[kDX21ParamLFOSpeed]
        self.LFODelay                       = d[kDX21ParamLFODelay]
        self.pitchModDepth                  = d[kDX21ParamPitchModDepth]
        self.amplitudeModDepth              = d[kDX21ParamAmplitudeModDepth]
        self.LFOSync                        = d[kDX21ParamLFOSync]
        self.LFOWave                        = d[kDX21ParamLFOWave]
        self.pitchModSensitivity            = d[kDX21ParamPitchModSensitivity]
        self.amplitudeModSensitivity        = d[kDX21ParamAmplitudeModSensitivity]
        self.transpose                      = d[kDX21ParamTranspose]
        self.polyOrMonoPlayMode             = d[kDX21ParamPolyOrMonoPlayMode]
        self.pitchBendRange                 = d[kDX21ParamPitchBendRange]
        self.portamentoMode                 = d[kDX21ParamPortamentoMode]
        self.portamentoTime                 = d[kDX21ParamPortamentoTime]
        self.footVolume                     = d[kDX21ParamFootVolume]
        self.sustainFootSwitch              = d[kDX21ParamSustainFootSwitch]
        self.portamentoFootSwitch           = d[kDX21ParamPortamentoFootSwitch]
        self.chorusSwitch                   = d[kDX21ParamChorusSwitch]
        self.modWheelPitchModRange          = d[kDX21ParamModWheelPitchModRange]
        self.modWheelAmplitudeModRange      = d[kDX21ParamModWheelAmplitudeModRange]
        self.breathControlPitchModRange     = d[kDX21ParamBreathControlPitchModRange]
        self.breathControlAmplitudeModRange = d[kDX21ParamBreathControlAmplitudeModRange]
        self.breathControlPitchBiasRange    = d[kDX21ParamBreathControlPitchBiasRange]
        self.breathControlEGBiasRange       = d[kDX21ParamBreathControlEGBiasRange]
        self.voiceName0                     = d[kDX21ParamVoiceName0]
        self.voiceName1                     = d[kDX21ParamVoiceName1]
        self.voiceName2                     = d[kDX21ParamVoiceName2]
        self.voiceName3                     = d[kDX21ParamVoiceName3]
        self.voiceName4                     = d[kDX21ParamVoiceName4]
        self.voiceName5                     = d[kDX21ParamVoiceName5]
        self.voiceName6                     = d[kDX21ParamVoiceName6]
        self.voiceName7                     = d[kDX21ParamVoiceName7]
        self.voiceName8                     = d[kDX21ParamVoiceName8]
        self.voiceName9                     = d[kDX21ParamVoiceName9]
        self.pitchEGRate1                   = d[kDX21ParamPitchEGRate1]
        self.pitchEGRate2                   = d[kDX21ParamPitchEGRate2]
        self.pitchEGRate3                   = d[kDX21ParamPitchEGRate3]
        self.pitchEGLevel1                  = d[kDX21ParamPitchEGLevel1]
        self.pitchEGLevel2                  = d[kDX21ParamPitchEGLevel2]
        self.pitchEGLevel3                  = d[kDX21ParamPitchEGLevel3]
    }
    
    public convenience init(bulkVoiceData data: Data) {
        
        var d = Data(count: 93)
        
        d[kDX21ParamOp1AttackRate]              = data[0]
        d[kDX21ParamOp1DecayRate1]              = data[1]
        d[kDX21ParamOp1DecayRate2]              = data[2]
        d[kDX21ParamOp1ReleaseRate]             = data[3]
        d[kDX21ParamOp1DecayLevel1]             = data[4]
        d[kDX21ParamOp1KeyboardScalingLevel]    = data[5]
        d[kDX21ParamOp1KeyboardScalingRate]     = data[9]
        d[kDX21ParamOp1EGBiasSensitivity]       = data[6]
        d[kDX21ParamOp1AmplitudeModEnable]      = data[6]
        d[kDX21ParamOp1KeyVelocity]             = data[6]
        d[kDX21ParamOp1OutputLevel]             = data[7]
        d[kDX21ParamOp1OscillatorFrequency]     = data[8]
        d[kDX21ParamOp1Detune]                  = data[9]
        
        d[kDX21ParamOp2AttackRate]              = data[10]
        d[kDX21ParamOp2DecayRate1]              = data[11]
        d[kDX21ParamOp2DecayRate2]              = data[12]
        d[kDX21ParamOp2ReleaseRate]             = data[13]
        d[kDX21ParamOp2DecayLevel1]             = data[14]
        d[kDX21ParamOp2KeyboardScalingLevel]    = data[15]
        d[kDX21ParamOp2KeyboardScalingRate]     = data[19]
        d[kDX21ParamOp2EGBiasSensitivity]       = data[16]
        d[kDX21ParamOp2AmplitudeModEnable]      = data[16]
        d[kDX21ParamOp2KeyVelocity]             = data[16]
        d[kDX21ParamOp2OutputLevel]             = data[17]
        d[kDX21ParamOp2OscillatorFrequency]     = data[18]
        d[kDX21ParamOp2Detune]                  = data[19]
        
        d[kDX21ParamOp3AttackRate]              = data[20]
        d[kDX21ParamOp3DecayRate1]              = data[21]
        d[kDX21ParamOp3DecayRate2]              = data[22]
        d[kDX21ParamOp3ReleaseRate]             = data[23]
        d[kDX21ParamOp3DecayLevel1]             = data[24]
        d[kDX21ParamOp3KeyboardScalingLevel]    = data[25]
        d[kDX21ParamOp3KeyboardScalingRate]     = data[29]
        d[kDX21ParamOp3EGBiasSensitivity]       = data[26]
        d[kDX21ParamOp3AmplitudeModEnable]      = data[26]
        d[kDX21ParamOp3KeyVelocity]             = data[26]
        d[kDX21ParamOp3OutputLevel]             = data[27]
        d[kDX21ParamOp3OscillatorFrequency]     = data[28]
        d[kDX21ParamOp3Detune]                  = data[29]
        
        d[kDX21ParamOp4AttackRate]              = data[30]
        d[kDX21ParamOp4DecayRate1]              = data[31]
        d[kDX21ParamOp4DecayRate2]              = data[32]
        d[kDX21ParamOp4ReleaseRate]             = data[33]
        d[kDX21ParamOp4DecayLevel1]             = data[34]
        d[kDX21ParamOp4KeyboardScalingLevel]    = data[35]
        d[kDX21ParamOp4KeyboardScalingRate]     = data[39]
        d[kDX21ParamOp4EGBiasSensitivity]       = data[36]
        d[kDX21ParamOp4AmplitudeModEnable]      = data[36]
        d[kDX21ParamOp4KeyVelocity]             = data[36]
        d[kDX21ParamOp4OutputLevel]             = data[37]
        d[kDX21ParamOp4OscillatorFrequency]     = data[38]
        d[kDX21ParamOp4Detune]                  = data[39]
        d[kDX21ParamAlgorithm]                  = data[40]
        d[kDX21ParamFeedbackLevel]              = data[40]
        d[kDX21ParamLFOSpeed]                   = data[41]
        d[kDX21ParamLFODelay]                   = data[42]
        d[kDX21ParamPitchModDepth]              = data[43]
        d[kDX21ParamAmplitudeModDepth]          = data[44]
        d[kDX21ParamLFOSync]                    = data[40]
        d[kDX21ParamLFOWave]                    = data[45]
        d[kDX21ParamPitchModSensitivity]        = data[45]
        d[kDX21ParamAmplitudeModSensitivity]    = data[45]
        d[kDX21ParamTranspose]                  = data[46]
        d[kDX21ParamPolyOrMonoPlayMode]         = data[48]
        d[kDX21ParamPitchBendRange]             = data[47]
        d[kDX21ParamPortamentoMode]             = data[48]
        d[kDX21ParamPortamentoTime]             = data[49]
        d[kDX21ParamFootVolume]                 = data[50]
        d[kDX21ParamSustainFootSwitch]          = data[48]
        d[kDX21ParamPortamentoFootSwitch]       = data[48]
        d[kDX21ParamChorusSwitch]               = data[48]
        
        d[kDX21ParamModWheelPitchModRange]              = data[51]
        d[kDX21ParamModWheelAmplitudeModRange]          = data[52]
        d[kDX21ParamBreathControlPitchModRange]         = data[53]
        d[kDX21ParamBreathControlAmplitudeModRange]     = data[54]
        d[kDX21ParamBreathControlPitchBiasRange]        = data[55]
        d[kDX21ParamBreathControlEGBiasRange]           = data[56]
        
        d[kDX21ParamVoiceName0]                         = data[57]
        d[kDX21ParamVoiceName1]                         = data[58]
        d[kDX21ParamVoiceName2]                         = data[59]
        d[kDX21ParamVoiceName3]                         = data[60]
        d[kDX21ParamVoiceName4]                         = data[61]
        d[kDX21ParamVoiceName5]                         = data[62]
        d[kDX21ParamVoiceName6]                         = data[63]
        d[kDX21ParamVoiceName7]                         = data[64]
        d[kDX21ParamVoiceName8]                         = data[65]
        d[kDX21ParamVoiceName9]                         = data[66]
        
        d[kDX21ParamPitchEGRate1]                       = data[67]
        d[kDX21ParamPitchEGRate2]                       = data[68]
        d[kDX21ParamPitchEGRate3]                       = data[69]
        d[kDX21ParamPitchEGLevel1]                      = data[70]
        d[kDX21ParamPitchEGLevel2]                      = data[71]
        d[kDX21ParamPitchEGLevel3]                      = data[72]
        
        self.init(singleVoiceData: d)
    }
    
    public convenience init() {
        
        var d = Data(count: 93)
        
        d[kDX21ParamOp1AttackRate]              = 0
        d[kDX21ParamOp1DecayRate1]              = 0
        d[kDX21ParamOp1DecayRate2]              = 0
        d[kDX21ParamOp1ReleaseRate]             = 0
        d[kDX21ParamOp1DecayLevel1]             = 0
        d[kDX21ParamOp1KeyboardScalingLevel]    = 0
        d[kDX21ParamOp1KeyboardScalingRate]     = 0
        d[kDX21ParamOp1EGBiasSensitivity]       = 0
        d[kDX21ParamOp1AmplitudeModEnable]      = 0
        d[kDX21ParamOp1KeyVelocity]             = 0
        d[kDX21ParamOp1OutputLevel]             = 0
        d[kDX21ParamOp1OscillatorFrequency]     = 0
        d[kDX21ParamOp1Detune]                  = 0
        
        d[kDX21ParamOp2AttackRate]              = 0
        d[kDX21ParamOp2DecayRate1]              = 0
        d[kDX21ParamOp2DecayRate2]              = 0
        d[kDX21ParamOp2ReleaseRate]             = 0
        d[kDX21ParamOp2DecayLevel1]             = 0
        d[kDX21ParamOp2KeyboardScalingLevel]    = 0
        d[kDX21ParamOp2KeyboardScalingRate]     = 0
        d[kDX21ParamOp2EGBiasSensitivity]       = 0
        d[kDX21ParamOp2AmplitudeModEnable]      = 0
        d[kDX21ParamOp2KeyVelocity]             = 0
        d[kDX21ParamOp2OutputLevel]             = 0
        d[kDX21ParamOp2OscillatorFrequency]     = 0
        d[kDX21ParamOp2Detune]                  = 0
        
        d[kDX21ParamOp3AttackRate]              = 0
        d[kDX21ParamOp3DecayRate1]              = 0
        d[kDX21ParamOp3DecayRate2]              = 0
        d[kDX21ParamOp3ReleaseRate]             = 0
        d[kDX21ParamOp3DecayLevel1]             = 0
        d[kDX21ParamOp3KeyboardScalingLevel]    = 0
        d[kDX21ParamOp3KeyboardScalingRate]     = 0
        d[kDX21ParamOp3EGBiasSensitivity]       = 0
        d[kDX21ParamOp3AmplitudeModEnable]      = 0
        d[kDX21ParamOp3KeyVelocity]             = 0
        d[kDX21ParamOp3OutputLevel]             = 0
        d[kDX21ParamOp3OscillatorFrequency]     = 0
        d[kDX21ParamOp3Detune]                  = 0
        
        d[kDX21ParamOp4AttackRate]              = 0
        d[kDX21ParamOp4DecayRate1]              = 0
        d[kDX21ParamOp4DecayRate2]              = 0
        d[kDX21ParamOp4ReleaseRate]             = 0
        d[kDX21ParamOp4DecayLevel1]             = 0
        d[kDX21ParamOp4KeyboardScalingLevel]    = 0
        d[kDX21ParamOp4KeyboardScalingRate]     = 0
        d[kDX21ParamOp4EGBiasSensitivity]       = 0
        d[kDX21ParamOp4AmplitudeModEnable]      = 0
        d[kDX21ParamOp4KeyVelocity]             = 0
        d[kDX21ParamOp4OutputLevel]             = 0
        d[kDX21ParamOp4OscillatorFrequency]     = 0
        d[kDX21ParamOp4Detune]                  = 0
        d[kDX21ParamAlgorithm]                  = 0
        d[kDX21ParamFeedbackLevel]              = 0
        d[kDX21ParamLFOSpeed]                   = 0
        d[kDX21ParamLFODelay]                   = 0
        d[kDX21ParamPitchModDepth]              = 0
        d[kDX21ParamAmplitudeModDepth]          = 0
        d[kDX21ParamLFOSync]                    = 0
        d[kDX21ParamLFOWave]                    = 0
        d[kDX21ParamPitchModSensitivity]        = 0
        d[kDX21ParamAmplitudeModSensitivity]    = 0
        d[kDX21ParamTranspose]                  = 0
        d[kDX21ParamPolyOrMonoPlayMode]         = 0
        d[kDX21ParamPitchBendRange]             = 0
        d[kDX21ParamPortamentoMode]             = 0
        d[kDX21ParamPortamentoTime]             = 0
        d[kDX21ParamFootVolume]                 = 0
        d[kDX21ParamSustainFootSwitch]          = 0
        d[kDX21ParamPortamentoFootSwitch]       = 0
        d[kDX21ParamChorusSwitch]               = 0
        
        d[kDX21ParamModWheelPitchModRange]              = 0
        d[kDX21ParamModWheelAmplitudeModRange]          = 0
        d[kDX21ParamBreathControlPitchModRange]         = 0
        d[kDX21ParamBreathControlAmplitudeModRange]     = 0
        d[kDX21ParamBreathControlPitchBiasRange]        = 0
        d[kDX21ParamBreathControlEGBiasRange]           = 0
        
        d[kDX21ParamVoiceName0]                         = 0
        d[kDX21ParamVoiceName1]                         = 0
        d[kDX21ParamVoiceName2]                         = 0
        d[kDX21ParamVoiceName3]                         = 0
        d[kDX21ParamVoiceName4]                         = 0
        d[kDX21ParamVoiceName5]                         = 0
        d[kDX21ParamVoiceName6]                         = 0
        d[kDX21ParamVoiceName7]                         = 0
        d[kDX21ParamVoiceName8]                         = 0
        d[kDX21ParamVoiceName9]                         = 0
        
        d[kDX21ParamPitchEGRate1]                       = 0
        d[kDX21ParamPitchEGRate2]                       = 0
        d[kDX21ParamPitchEGRate3]                       = 0
        d[kDX21ParamPitchEGLevel1]                      = 0
        d[kDX21ParamPitchEGLevel2]                      = 0
        d[kDX21ParamPitchEGLevel3]                      = 0
        
        
        self.init(singleVoiceData: d)
    }
}



