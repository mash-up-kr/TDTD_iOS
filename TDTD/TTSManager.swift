//
//  TTSManager.swift
//  TDTD
//
//  Created by 남수김 on 2021/02/26.
//

import AVFoundation

final class TTSManager: NSObject {
    private override init() {}
    static let shared: TTSManager = TTSManager()
    
    // MARK: - TTS관련 객체
    private let speaker: AVSpeechSynthesizer = AVSpeechSynthesizer()
    private let voice: AVSpeechSynthesisVoice? = AVSpeechSynthesisVoice(language: "ko-KR")
    
    func speakText(_ text: String) {
        try? AVAudioSession.sharedInstance().setCategory(.playback,
                                                         options: [.allowBluetooth, .duckOthers])
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = voice
        speaker.speak(utterance)
    }
}
