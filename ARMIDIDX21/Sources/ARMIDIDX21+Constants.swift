//
//  ARMIDIDX21+Constants.swift
//  ARMIDI
//
//  Created by Aaron Rasmussen on 10/8/24.
//

public let kYamahaSysExID                       = 0x43      // 67
public let kDX21ParamGroupNumber                = 0x12      // 18
public let kDX21ParamChangeTxByteCount          = 0x07      // 7
public let kDX21ParamChangeDataByteCount        = 0x02      // 2
public let kDX21SingleVoiceTxByteCount          = 0x65      // 101
public let kDX21SingleVoiceDataByteCount        = 0x5D      // 93
public let kDX21AllVoicesTxByteCount            = 0x2008    // 4,104
public let kDX21AllVoicesDataByteCount          = 0x2000    // 4,096
public let kDX21SingleVoiceBulkFormat           = 0x03      // 3
public let kDX21AllVoicesBulkFormat             = 0x04      // 4

public let kDX21ParamOp1AttackRate                  = 0
public let kDX21ParamOp1DecayRate1                  = 1
public let kDX21ParamOp1DecayRate2                  = 2
public let kDX21ParamOp1ReleaseRate                 = 3
public let kDX21ParamOp1DecayLevel1                 = 4
public let kDX21ParamOp1KeyboardScalingLevel        = 5
public let kDX21ParamOp1KeyboardScalingRate         = 6
public let kDX21ParamOp1EGBiasSensitivity           = 7
public let kDX21ParamOp1AmplitudeModEnable          = 8
public let kDX21ParamOp1KeyVelocity                 = 9
public let kDX21ParamOp1OutputLevel                 = 10
public let kDX21ParamOp1OscillatorFrequency         = 11
public let kDX21ParamOp1Detune                      = 12

public let kDX21ParamOp2AttackRate                  = 13
public let kDX21ParamOp2DecayRate1                  = 14
public let kDX21ParamOp2DecayRate2                  = 15
public let kDX21ParamOp2ReleaseRate                 = 16
public let kDX21ParamOp2DecayLevel1                 = 17
public let kDX21ParamOp2KeyboardScalingLevel        = 18
public let kDX21ParamOp2KeyboardScalingRate         = 19
public let kDX21ParamOp2EGBiasSensitivity           = 20
public let kDX21ParamOp2AmplitudeModEnable          = 21
public let kDX21ParamOp2KeyVelocity                 = 22
public let kDX21ParamOp2OutputLevel                 = 23
public let kDX21ParamOp2OscillatorFrequency         = 24
public let kDX21ParamOp2Detune                      = 25

public let kDX21ParamOp3AttackRate                  = 26
public let kDX21ParamOp3DecayRate1                  = 27
public let kDX21ParamOp3DecayRate2                  = 28
public let kDX21ParamOp3ReleaseRate                 = 29
public let kDX21ParamOp3DecayLevel1                 = 30
public let kDX21ParamOp3KeyboardScalingLevel        = 31
public let kDX21ParamOp3KeyboardScalingRate         = 32
public let kDX21ParamOp3EGBiasSensitivity           = 33
public let kDX21ParamOp3AmplitudeModEnable          = 34
public let kDX21ParamOp3KeyVelocity                 = 35
public let kDX21ParamOp3OutputLevel                 = 36
public let kDX21ParamOp3OscillatorFrequency         = 37
public let kDX21ParamOp3Detune                      = 38

public let kDX21ParamOp4AttackRate                  = 39
public let kDX21ParamOp4DecayRate1                  = 40
public let kDX21ParamOp4DecayRate2                  = 41
public let kDX21ParamOp4ReleaseRate                 = 42
public let kDX21ParamOp4DecayLevel1                 = 43
public let kDX21ParamOp4KeyboardScalingLevel        = 44
public let kDX21ParamOp4KeyboardScalingRate         = 45
public let kDX21ParamOp4EGBiasSensitivity           = 46
public let kDX21ParamOp4AmplitudeModEnable          = 47
public let kDX21ParamOp4KeyVelocity                 = 48
public let kDX21ParamOp4OutputLevel                 = 49
public let kDX21ParamOp4OscillatorFrequency         = 50
public let kDX21ParamOp4Detune                      = 51

public let kDX21ParamAlgorithm                      = 52
public let kDX21ParamFeedbackLevel                  = 53
public let kDX21ParamLFOSpeed                       = 54
public let kDX21ParamLFODelay                       = 55
public let kDX21ParamPitchModDepth                  = 56
public let kDX21ParamAmplitudeModDepth              = 57
public let kDX21ParamLFOSync                        = 58
public let kDX21ParamLFOWave                        = 59
public let kDX21ParamPitchModSensitivity            = 60
public let kDX21ParamAmplitudeModSensitivity        = 61
public let kDX21ParamTranspose                      = 62
public let kDX21ParamPolyOrMonoPlayMode             = 63
public let kDX21ParamPitchBendRange                 = 64
public let kDX21ParamPortamentoMode                 = 65
public let kDX21ParamPortamentoTime                 = 66
public let kDX21ParamFootVolume                     = 67
public let kDX21ParamSustainFootSwitch              = 68
public let kDX21ParamPortamentoFootSwitch           = 69
public let kDX21ParamChorusSwitch                   = 70

public let kDX21ParamModWheelPitchModRange          = 71
public let kDX21ParamModWheelAmplitudeModRange      = 72

public let kDX21ParamBreathControlPitchModRange     = 73
public let kDX21ParamBreathControlAmplitudeModRange = 74
public let kDX21ParamBreathControlPitchBiasRange    = 75
public let kDX21ParamBreathControlEGBiasRange       = 76

public let kDX21ParamVoiceName0                     = 77
public let kDX21ParamVoiceName1                     = 78
public let kDX21ParamVoiceName2                     = 79
public let kDX21ParamVoiceName3                     = 80
public let kDX21ParamVoiceName4                     = 81
public let kDX21ParamVoiceName5                     = 82
public let kDX21ParamVoiceName6                     = 83
public let kDX21ParamVoiceName7                     = 84
public let kDX21ParamVoiceName8                     = 85
public let kDX21ParamVoiceName9                     = 86

public let kDX21ParamPitchEGRate1                   = 87
public let kDX21ParamPitchEGRate2                   = 88
public let kDX21ParamPitchEGRate3                   = 89
public let kDX21ParamPitchEGLevel1                  = 90
public let kDX21ParamPitchEGLevel2                  = 91
public let kDX21ParamPitchEGLevel3                  = 92

public let kDX21FunctionOperatorEnableDisable          = 93
public let kDX21FunctionOperatorSelect                 = 94

public let kDX21FunctionEditModeOn                     = 95
public let kDX21FunctionFunctionModeOn                 = 96
public let kDX21FunctionStoreModeOn                    = 97
public let kDX21FunctionPlayDualModeOn                 = 98
public let kDX21FunctionPlaySplitModeOn                = 99
public let kDX21FunctionPlaySingleModeOn               = 100
public let kDX21FunctionDualModeDetune                 = 101
public let kDX21FunctionSplitPoint                     = 102
public let kDX21FunctionMasterTune                     = 103

public let kDX21FunctionMIDISwitchOn                   = 104
public let kDX21FunctionMIDIChannelInfo                = 105
public let kDX21FunctionMIDIOmniOn                     = 106
public let kDX21FunctionMIDITransmitChannel            = 107
public let kDX21FunctionMIDIReceiveChannel             = 108
public let kDX21FunctionMIDISystemInfo                 = 109
public let kDX21FunctionMIDIBulkDump                   = 110
public let kDX21FunctionMIDIEditRecall                 = 111
public let kDX21FunctionMIDIInitVoice                  = 112

public let kDX21FunctionMemoryProtectOn                = 119
public let kDX21FunctionKeyShift                       = 120
public let kDX21FunctionPitchBendModeOn                = 121
public let kDX21FunctionKeyShiftOn                     = 122
public let kDX21FunctionCompare                        = 123
public let kDX21FunctionPitchBendMode                  = 124
