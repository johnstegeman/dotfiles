import CoreAudio

func getDefaultInputDevice() -> AudioDeviceID {
    var device: AudioDeviceID = kAudioObjectUnknown
    var size = UInt32(MemoryLayout<AudioDeviceID>.size)
    var addr = AudioObjectPropertyAddress(
        mSelector: kAudioHardwarePropertyDefaultInputDevice,
        mScope: kAudioObjectPropertyScopeGlobal,
        mElement: kAudioObjectPropertyElementMain
    )
    AudioObjectGetPropertyData(AudioObjectID(kAudioObjectSystemObject), &addr, 0, nil, &size, &device)
    return device
}

func getMute(_ device: AudioDeviceID) -> UInt32? {
    var mute: UInt32 = 0
    var size = UInt32(MemoryLayout<UInt32>.size)
    var addr = AudioObjectPropertyAddress(
        mSelector: kAudioDevicePropertyMute,
        mScope: kAudioDevicePropertyScopeInput,
        mElement: kAudioObjectPropertyElementMain
    )
    let err = AudioObjectGetPropertyData(device, &addr, 0, nil, &size, &mute)
    return err == noErr ? mute : nil
}

func setMute(_ device: AudioDeviceID, _ mute: UInt32) {
    var val = mute
    let size = UInt32(MemoryLayout<UInt32>.size)
    var addr = AudioObjectPropertyAddress(
        mSelector: kAudioDevicePropertyMute,
        mScope: kAudioDevicePropertyScopeInput,
        mElement: kAudioObjectPropertyElementMain
    )
    AudioObjectSetPropertyData(device, &addr, 0, nil, size, &val)
}

let device = getDefaultInputDevice()
guard device != kAudioObjectUnknown else { print("false"); exit(0) }

let toggle = CommandLine.arguments.contains("--toggle")

if toggle {
    if let current = getMute(device) {
        setMute(device, current == 0 ? 1 : 0)
    }
}

let mute = getMute(device) ?? 0
print(mute == 1 ? "true" : "false")
