//
//  RecordManager.swift
//  TDTD
//
//  Created by 남수김 on 2021/02/26.
//

import AVFoundation

final class RecordManager: NSObject {
    private override init() {}
    static let shared: RecordManager = RecordManager()
    var limitDuration: TimeInterval = 60
    private var recorder: AVAudioRecorder!
    private var fileName: String = ""
    var recorderURL: URL {
        recorder.url
    }
    var recordTime: TimeInterval {
        recorder.currentTime
    }
    unowned var delegate: RecordManagerDelegate?
    
    private func setAudioSession() {
        try? AVAudioSession.sharedInstance().setCategory(.playAndRecord,
                                                         options: [.allowBluetooth, .defaultToSpeaker])
    }
    
    private func setRecorder() throws {
        var fileURL = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        fileName = "/tdtd\(Date().fileFormat).wav"
        fileURL.append(fileName)
        
        recorder = try AVAudioRecorder(url: URL(string: fileURL)!, settings: [:])
        recorder.delegate = self
        
    }
    
    func record() throws {
        setAudioSession()
        try setRecorder()
        try AVAudioSession.sharedInstance().setActive(true)
        recorder.record(forDuration: limitDuration)
    }
    
    func stop() {
        recorder.stop()
        try? AVAudioSession.sharedInstance().setActive(false)
    }
    
}

// MARK: - RecorderDelegate

extension RecordManager: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("녹음완료")
            print(recorder.url)
            if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName) {
                delegate?.recordComplete(recordFile: try? Data(contentsOf: url))
            }
        } else {
            print("녹음실패")
        }
    }
}

// MARK: - Debug

extension RecordManager {
    /// 디버깅용 파일 탐색 함수
    private func searchRecordFile() {
        let urlString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        print(urlString)
        if let urls = try? FileManager.default.subpathsOfDirectory(atPath: urlString) {
            for path in urls {
                print("\(urlString)/\(path)")
            }
        }
    }
    
    func deleteAllFile() {
        let urlString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        if let urls = try? FileManager.default.subpathsOfDirectory(atPath: urlString) {
            for path in urls {
                try? FileManager.default.removeItem(atPath: "\(urlString)/\(path)")
            }
        }
    }
}
