//
//  RollingpagerWriteViewModel.swift
//  TDTD
//
//  Created by 남수김 on 2021/02/27.
//

import SwiftUI
import Combine
import Moya

enum RecordStatus {
    case none, record, end, play, pause
}
enum WriteMode: String {
    case text = "TEXT"
    case voice = "VOICE"
}
final class RollingpaperWriteViewModel: ObservableObject {
    @Published var model: RollingpaperWriteModel
    @Published var recordStatus: RecordStatus = .none
    private let roomCode: String
    
    var subTitle: String {
        switch model.mode {
        case .text:
            return "남기고 싶은 말을 써주세요!"
        case .voice:
            return "남기고 싶은 말을 속삭여주세요!"
        }
    }
    
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
    // 키보드 올라옴 유무
    @Published var isEditing: Bool = false
    private var timerCancellable: AnyCancellable?
    @Published var timerString: String = "최대 1분"
    private var cancelBag = Set<AnyCancellable>()
    
    init(roomCode: String, mode: WriteMode = .text) {
        self.roomCode = roomCode
        model = RollingpaperWriteModel(mode: mode)
        RecordManager.shared.delegate = self
        
        // FIXME: - 디버그용 추후 삭제 해야해용
        $model.sink {
            print($0)
        }
        .store(in: &cancelBag)
    }
    
    func record() {
        recordStatus = .record
        try? RecordManager.shared.record()
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                print(RecordManager.shared.recordTime)
                if RecordManager.shared.recordTime >= RecordManager.shared.limitDuration {
                    self.stopRecord()
                }
                self.timerString = String(format: "00:%02d", Int(floor(RecordManager.shared.recordTime)))
            }
    }
    
    func stopRecord() {
        recordStatus = .end
        RecordManager.shared.stop()
        timerCancellable?.cancel()
    }
    
    func play() {
        recordStatus = .play
        do {
            try PlayManager.shared.play(RecordManager.shared.recorderURL)
            var timer: Double = 0.0
            timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    timer += 1
                    if PlayManager.shared.playTime <= timer {
                        self.playFinish()
                    }
                }
        } catch {
            print("player error")
        }
    }
    
    func reset() {
        timerString = "최대 1분"
        recordStatus = .none
        PlayManager.shared.stop()
        RecordManager.shared.deleteAllFile()
        model.voice = nil
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
            stopRecord()
        case .play:
            pause()
        case .end:
            play()
        case .pause:
            play()
        }
    }
    
    func playFinish() {
        recordStatus = .end
        PlayManager.shared.stop()
        timerCancellable?.cancel()
    }
}

extension RollingpaperWriteViewModel: RecordManagerDelegate {
    func recordComplete(recordFile: Data?) {
        model.voice = recordFile
    }
}

protocol RecordManagerDelegate: class {
    func recordComplete(recordFile: Data?)
}

extension RollingpaperWriteViewModel {
    func requestWriteComment() {
        APIRequest.shared.requestWriteComment(roomCode: roomCode, data: model.multipartData)
            .replaceError(with: Response(statusCode: -1, data: Data()))
            .sink {
                print($0)
            }
            .store(in: &cancelBag)
    }
}
