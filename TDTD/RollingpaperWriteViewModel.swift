//
//  RollingpagerWriteViewModel.swift
//  TDTD
//
//  Created by 남수김 on 2021/02/27.
//

import Foundation

class RollingpaperWriteViewModel: ObservableObject {
    enum WriteMode {
        case text, voice
    }
    enum RecordStatus {
        case none, record, end, play, pause
    }
    
    let mode: WriteMode
    @Published private var recordStatus: RecordStatus = .none
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
    @Published var isEditing = false
    
    init(mode: WriteMode = .text) {
        self.mode = mode
    }
    
    func record() {
        recordStatus = .record
    }
    
    func stop() {
        recordStatus = .end
    }
    
    func play() {
        recordStatus = .play
    }
    
    func reset() {
        recordStatus = .none
    }
    
    func pause() {
        recordStatus = .pause
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
