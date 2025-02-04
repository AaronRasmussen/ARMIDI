Pod::Spec.new do |spec|

    spec.name                   = 'ARMIDI'
    spec.version                = '0.3.0'
    spec.summary                = 'A framework for working with CoreMIDI in Swift.'
    spec.description            = <<-DESC
        CoreMIDI is a pain in the ass. This pod makes it easier to for me to write CoreMIDI code in Swift. What does it do? you ask. It does what I need it to. Nothing more, nothing less. I have a Yamaha DX21 and I wanted to use my computer to do cool MIDI stuff with it. It is the code I use when I want to play with my toys.
                                DESC
                                
    spec.homepage               = 'https://github.com/AaronRasmussen/ARMIDI.git'
    spec.license                = { :type => 'MIT', :file => 'LICENSE' }
    spec.author                 = { 'Aaron Rasmussen' => 'aaron.rasmussen@me.com' }
    spec.source                 = { :git => 'https://github.com/AaronRasmussen/ARMIDI.git', :tag => spec.version.to_s }
    spec.platform               = :osx
    spec.osx.deployment_target  = "10.15"
    spec.swift_version          = '5.3'
    spec.source_files           = 'ARMIDI/*'
    spec.framework              = 'CoreMIDI'
    
    spec.dependency             'ARMIDIError'
end
