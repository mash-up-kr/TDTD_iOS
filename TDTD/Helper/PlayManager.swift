//
//  PlayManager.swift
//  TDTD
//
//  Created by 남수김 on 2021/02/26.
//

import AVFoundation

final class PlayManager {
    private init() {}
    static let shared: PlayManager = PlayManager()
    
    private var player: AVAudioPlayer?
    
    private func setAudioSession() {
        try? AVAudioSession.sharedInstance().setCategory(.playAndRecord,
                                                         options: [.allowBluetooth, .defaultToSpeaker])
    }
    
    func play<T>(_ file: T) throws {
        if file is Data {
            player = try AVAudioPlayer(data: file as! Data)
        } else if file is URL {
            player = try AVAudioPlayer(contentsOf: file as! URL)
        }
        
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        player?.stop()
    }
    
    var playTime: TimeInterval {
        player?.duration ?? 0
    }
}
