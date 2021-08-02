//
//  RollingpaperViewModel.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/09.
//

import SwiftUI
import Combine

import FirebaseAnalytics

enum PlayMode {
    case none, play, end, pause
}

final class RollingpaperViewModel: ObservableObject {
    @Published private(set) var models: [RollingpaperModel] = []
    
    @Published var isBookmark: Bool = false
    @Published var isHost: Bool = false
    @Published var roomType: RoomType = .none
    @Published var roomTitleText: String = ""
    @Published var isRoomRemoved: Bool = false
    @Published var isRequestErrorAlert: Bool?
    @Published var isCommentRemoved: Bool = false
    @Published var isMakeRoom: Bool = false
    @Published var curPlayTime: String = "00:00"
    @Published var totalPlayTime: String = "00:00"
    @Published var progressRate: Float = 0
    @Published var isPlay: Bool = false
    @Published var isEnableWriteButton: Bool = false
    @Published var isModifyRoomTitleResponseCode: Int = 0
    
    private(set) var roomCreatedAt: String?
    private var playMode: PlayMode = .none
    
    private var timerCancellable: AnyCancellable?
    
    var selectIndex: Int?
    var selectModel: RollingpaperModel? {
        if let index = selectIndex {
            return models[index]
        } else {
            return nil
        }
    }
    
    let roomCode: String
    private var requestBookmarkCancellable: AnyCancellable?
    private var requestRemoveRoomCancellable: AnyCancellable?
    private var requestReportCancellable: AnyCancellable?
    private var requestRemoveCommentCancellable: AnyCancellable?
    private var requestModifyRoomTitleCancellable: AnyCancellable?
    private var cancelBag = Set<AnyCancellable>()
    private(set) var shareURL: String = ""
    
    /// - 방리스트에서 선택했을 때 사용하는 생성자
    init(roomInfo: RoomSummary) {
        self.roomCode = roomInfo.roomCode ?? ""
        self.isBookmark = roomInfo.isBookmark
        self.roomCreatedAt = roomInfo.createdAt ?? ""
    }
    
    /// - parameters:
    ///    - isMakeRoom: 바로 방만든경우 true
    /// - 방만든 직후 생성할 때 사용하는 생성자
    init(roomCode: String, roomType: RoomType) {
        self.isMakeRoom = true
        self.roomCode = roomCode
        self.roomType = roomType
    }
    
    deinit {
        playerReset()
    }
    
    /// 방정보 가져오기
    func requestRoomDetailInfo() {
        APIRequest.shared.requestRoomDetail(roomCode: roomCode)
            .replaceError(with: .init(statusCode: -1, data: Data()))
            .sink { [self] response in
                do {
                    let responseModel = try response.map(ResponseModel<RoomResponse>.self)
                    let model = RoomModel(model: responseModel.result)
                    roomType = model.type
                    isHost = model.isHost
                    shareURL = model.shareURL
                    withAnimation(.linear(duration: 0.3)) {
                        models = model.comments
                        roomTitleText = model.title
                        isEnableWriteButton = true
                    }
                } catch {
                    Log(error)
                }
            }
            .store(in: &cancelBag)
    }
    
    /// 즐겨찾기
    func requestBookmark(delete: Bool = false) {
        requestBookmarkCancellable?.cancel()
        requestBookmarkCancellable = APIRequest.shared.requestBookmark(roomCode: roomCode, delete: delete)
            .replaceError(with: .init(statusCode: -1, data: Data()))
            .sink { response in
                if response.statusCode == 200 {
                    self.isBookmark = !self.isBookmark
                    Analytics.logEvent(AnalyticsEventName.exitRoom,
                                       parameters: ["value": self.isBookmark ? "on" : "off"])
                } else {
                    self.isRequestErrorAlert = true
                }
            }
    }
    
    /// 관리자가 방을 삭제
    func requestRemoveRoom() {
        requestRemoveRoomCancellable?.cancel()
        requestRemoveRoomCancellable = APIRequest.shared.requestRemoveRoom(roomCode: roomCode)
            .replaceError(with: .init(statusCode: -1, data: Data()))
            .sink { [weak self] response in
                if response.statusCode == 200 {
                    Analytics.logEvent(AnalyticsEventName.exitRoom,
                                       parameters: ["value": "host"])
                    self?.isRoomRemoved = true
                } else {
                    self?.isRequestErrorAlert = true
                }
            }
    }
    
    /// 방 나가기
    func requestExitRoom() {
        requestRemoveRoomCancellable?.cancel()
        requestRemoveRoomCancellable = APIRequest.shared.requestExitRoom(roomCode: roomCode)
            .replaceError(with: .init(statusCode: -1, data: Data()))
            .sink { [weak self] response in
                if response.statusCode == 200 {
                    Analytics.logEvent(AnalyticsEventName.exitRoom,
                                       parameters: ["value": "user"])
                    self?.isRoomRemoved = true
                } else {
                    self?.isRequestErrorAlert = true
                }
            }
    }
    
    /// 신고
    func requestReport() {
        if let model = selectModel {
            requestReportCancellable?.cancel()
            requestReportCancellable = APIRequest.shared.requestReport(commentId: model.id)
                .replaceError(with: .init(statusCode: -1, data: Data()))
                .sink { response in
                    if response.statusCode == 200 {
                        Log("신고완료")
                    }
                }
        }
    }
    
    /// 답장 삭제
    func requestRemoveComment() {
        if isHost {
            Log("관리자가 삭제")
            requestRemoveCommentFromHost()
        } else {
            Log("유저가 삭제")
            requestRemoveCommentFromUser()
        }
    }
    
    /// 자신게시물 삭제
    private func requestRemoveCommentFromUser() {
        if let id = selectModel?.id {
            requestRemoveCommentCancellable?.cancel()
            requestRemoveCommentCancellable = APIRequest.shared.requestRemoveCommentFromUser(commentId: id)
                .replaceError(with: .init(statusCode: -1, data: Data()))
                .sink { [weak self] response in
                    if response.statusCode == 200 {
                        self?.removeModel(id: id)
                        Analytics.logEvent(AnalyticsEventName.removeMessage,
                                           parameters: ["value": "user"])
                        self?.isCommentRemoved = true
                    }
                }
        }
    }

    /// 관리자가 게시물 삭제
    private func requestRemoveCommentFromHost() {
        if let id = selectModel?.id {
            requestRemoveCommentCancellable?.cancel()
            requestRemoveCommentCancellable = APIRequest.shared.requestRemoveCommentFromHost(commentId: id)
                .replaceError(with: .init(statusCode: -1, data: Data()))
                .sink { [weak self] response in
                    if response.statusCode == 200 {
                        self?.removeModel(id: id)
                        Analytics.logEvent(AnalyticsEventName.removeMessage,
                                           parameters: ["value": "host"])
                        self?.isCommentRemoved = true
                    }
                }
        }
    }
    
    private func removeModel(id: Int) {
        let index = models.firstIndex { $0.id == id }
        if let index = index {
            models.remove(at: index)
        }
    }
    
    func speackButtonTouchUpInside() {
        isPlay = !isPlay
        isPlay ? play() : pause()
    }
    
    /// 방제목 수정
    func requestModifyRoomTitle(title: String) {
        Analytics.logEvent(AnalyticsEventName.modifyTitle,
                           parameters: ["value": "host"])
        requestModifyRoomTitleCancellable?.cancel()
        requestModifyRoomTitleCancellable = APIRequest.shared.requestModifyRoomTitle(roomCode: roomCode, title: title)
            .replaceError(with: .init(statusCode: -1, data: Data()))
            .sink { [weak self] response in
                self?.isModifyRoomTitleResponseCode = response.statusCode
            }

    }
}

// MARK: - PlayerView관련 동작

protocol PlayManagerDelegate: AnyObject {
    func loadAudioDataComplete()
    func finishedPlay()
}

extension RollingpaperViewModel: PlayManagerDelegate {
    func finishedPlay() {
        stop()
    }
    
    func loadAudioDataComplete() {
        DispatchQueue.main.async { [weak self] in
            self?.totalPlayTime = self?.convertTimeString(PlayManager.shared.playTime) ?? "00:00"
        }
        
        timerCancellable = Timer.publish(every: 0.05, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                if let curTime = self?.convertTimeString(PlayManager.shared.curTime) {
                    self?.curPlayTime = curTime
                    self?.progressRate = PlayManager.shared.progressRate
                }
            }
    }
    
    private func convertTimeString(_ time: TimeInterval) -> String {
        let min = Int(time / 60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let timerString = String(format: "%02d:%02d", min, sec)
        
        return timerString
    }
    
    
    private func play() {
        if playMode == .none {
            playMode = .play
            progressRate = 0
            PlayManager.shared.delegate = self
            if let model = selectModel, let url = URL(string: model.voiceURL ?? "") {
                do {
                    try PlayManager.shared.play(url)
                } catch {
                    Log(error)
                }
            }
        } else if playMode == .end || playMode == .pause {
            playMode = .play
            PlayManager.shared.play()
        }
    }
    
    private func pause() {
        playMode = .pause
        timerCancellable?.cancel()
        PlayManager.shared.pause()
    }
    
    private func stop() {
        playMode = .end
        timerCancellable?.cancel()
        progressRate = 1
        curPlayTime = totalPlayTime
        isPlay = false
    }
    
    func playerReset() {
        PlayManager.shared.stop()
        playMode = .none
        timerCancellable?.cancel()
        progressRate = 0
        isPlay = false
    }
}
