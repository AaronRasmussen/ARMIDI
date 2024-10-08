Pod::Spec.new do |spec|

    spec.name                   = 'ARMIDI'
    spec.version                = '0.1.5'
    spec.summary                = 'Layers of abstraction for working with CoreMIDI in pure Swift.'
    spec.description            = <<-DESC
        CoreMIDI's c interface is poorly documented and cumbersome. At the lowest level of abstraction, ARMIDI provides simple Swift wrappers for all of the CoreMIDIServices functions, available at the global level. At the next level of abstraction, protocols with default implementations are provided for the basic CoreMIDI Services components: objects, devices, entities, endpoints, ports, and clients. The final level of abstraction is a set of classes that implement the protocols and are available for subclassing. The ARMIDIError type provides a simple Swift Error type for handling the CoreMIDI OSStatus error codes. ARMIDIParser is a simple MIDI 1.0 parser engine.
                                DESC
    spec.homepage               = 'https://github.com/AaronRasmussen/ARMIDI.git'
    spec.license                = { :type => 'MIT', :file => 'LICENSE' }
    spec.author                 = { 'Aaron Rasmussen' => 'aaron.rasmussen@me.com' }
    spec.source                 = { :git => 'https://github.com/AaronRasmussen/ARMIDI.git', :tag => spec.version.to_s }
    spec.platform               = :osx
    spec.osx.deployment_target  = "10.15"
    spec.swift_version          = '5.3'
    spec.source_files           = 'ARMIDI*/**/*'
    spec.framework              = 'CoreMIDI'
        
    spec.subspec 'ARMIDIParser' do |pspec|
        pspec.source_files          = 'ARMIDIParser/Sources/**/*'
    end
    
    spec.subspec 'ARMIDIDX21' do |dxspec|
        dxspec.source_files          = 'ARMIDIDX21/Sources/**/*'
        dxspec.dependency            'ARMIDI/ARMIDIParser'
    end
    
    spec.subspec 'ARMIDIError' do |espec|
        espec.source_files          = 'ARMIDIError/Sources/**/*'
    end
    
    spec.subspec 'ARMIDIServices' do |sspec|
        sspec.source_files          = 'ARMIDIServices/Sources/**/*'
        sspec.dependency            'ARMIDI/ARMIDIError'
    end
    
    spec.subspec 'ARMIDIServices+Protocols' do |spspec|
        spspec.source_files          = 'ARMIDIServices+Protocols/Sources/**/*'
        spspec.dependency            'ARMIDI/ARMIDIServices'
    end
    
    spec.subspec 'ARMIDIServices+Classes' do |scspec|
        scspec.source_files          = 'ARMIDIServices+Classes/Sources/**/*'
        scspec.dependency            'ARMIDI/ARMIDIServices+Protocols'
    end
end
