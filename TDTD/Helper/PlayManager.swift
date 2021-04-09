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
    weak var delegate: PlayManagerDelegate?
    
    private func setAudioSession() {
        try? AVAudioSession.sharedInstance().setCategory(.playAndRecord,
                                                         options: [.allowBluetooth, .defaultToSpeaker])
    }
    
    private func requestAudioFile(_ url: URL, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                completion(data)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func play<T>(_ file: T) throws {
        if file is Data {
            player = try AVAudioPlayer(data: file as! Data)
            player?.play()
        } else if file is URL {
            requestAudioFile(file as! URL) { [weak self] audioData in
                if let audioData = audioData {
                    self?.player = try? AVAudioPlayer(data: audioData)
                    self?.delegate?.loadAudioDataComplete()
                    self?.player?.play()
                }
            }
        }
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
    
    var curTime: TimeInterval {
        player?.currentTime ?? 0
    }
    
    var progressRate: Float {
        Float(curTime / playTime)
    }
}
