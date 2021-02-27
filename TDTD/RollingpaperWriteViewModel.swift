//
//  RollingpagerWriteViewModel.swift
//  TDTD
//
//  Created by 남수김 on 2021/02/27.
//

import SwiftUI
import Combine

enum RecordStatus {
    case none, record, end, play, pause
}

class RollingpaperWriteViewModel: ObservableObject {
    enum WriteMode {
        case text, voice
    }
    
    let mode: WriteMode
    @Published var recordStatus: RecordStatus = .none
    var recordDescription: String {
        switch recordStatus {
        case .none:
            return "버튼을 눌러 녹음하기"
        case .record:
            return "녹음하고 있어요!"
        case .play:
            return "재생하고 있어요!"
        case .end:
            return "녹음 들어보기"
        case .pause:
            return "다시 재생하기"
        }
    }
    
    var recordImage: UIImage? {
        switch recordStatus {
        case .none:
            return UIImage(named: "icon_record_default")
        case .record:
            return UIImage(named: "icon_record_active")
        case .play:
            return UIImage(named: "icon_record_stop")
        case .end:
            return UIImage(named: "icon_record_play")
        case .pause:
            return UIImage(named: "icon_record_play")
        }
    }
    @Published var isEditing = false
    private var timerCancellable: AnyCancellable?
    
    init(mode: WriteMode = .text) {
        self.mode = mode
    }
    
    func record() {
        recordStatus = .record
        try? RecordManager.shared.record()
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                floor(RecordManager.shared.recordTime)
            }
    }
    
    func stop() {
        recordStatus = .end
        RecordManager.shared.stop()
        timerCancellable?.cancel()
    }
    
    func play() {
        recordStatus = .play
        try? PlayManager.shared.play(RecordManager.shared.recorderURL)
    }
    
    func reset() {
        recordStatus = .none
        PlayManager.shared.stop()
        RecordManager.shared.deleteAllFile()
    }
    
    func pause() {
        recordStatus = .pause
        PlayManager.shared.pause()
    }
    
    func recordButtonClick() {
        switch recordStatus {
        case .none:
            record()
        case .record:
            stop()
        case .play:
            pause()
        case .end:
            play()
        case .pause:
            play()
        }
    }
}
