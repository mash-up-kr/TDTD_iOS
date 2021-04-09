//
//  PlayManager.swift
//  TDTD
//
//  Created by 남수김 on 2021/02/26.
//

import AVFoundation

final class PlayManager: NSObject {
    private override init() {}
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
    
    /// 새파일 재생
    func play<T>(_ file: T, isRecord: Bool = false) throws {
        if file is Data {
            player = try AVAudioPlayer(data: file as! Data)
            player?.delegate = self
            player?.play()
        } else if file is URL {
            if isRecord {
                player = try? AVAudioPlayer(contentsOf: file as! URL)
                player?.play()
            } else {
                requestAudioFile(file as! URL) { [weak self] audioData in
                    if let audioData = audioData {
                        self?.player = try? AVAudioPlayer(data: audioData)
                        self?.player?.delegate = self
                        self?.delegate?.loadAudioDataComplete()
                        self?.player?.play()
                    }
                }
            }
        }
    }
    
    /// 기존파일 재생
    func play() {
        delegate?.loadAudioDataComplete()
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
    
    var curTime: TimeInterval {
        player?.currentTime ?? 0
    }
    
    var progressRate: Float {
        Float(curTime / playTime)
    }
}

extension PlayManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        delegate?.finishedPlay()
    }
}
