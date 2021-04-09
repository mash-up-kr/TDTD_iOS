//
//  RollingpaperViewModel.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/09.
//

import SwiftUI
import Combine

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
    private var cancelBag = Set<AnyCancellable>()
    private(set) var shareURL: String = ""
    
    /// - parameters:
    ///    - isMakeRoom: 바로 방만든경우 true
    init(roomCode: String, isMakeRoom: Bool = false) {
        self.roomCode = roomCode
        self.isMakeRoom = isMakeRoom
    }
    
    func requestRoomDetailInfo() {
        APIRequest.shared.requestRoomDetail(roomCode: roomCode)
            .replaceError(with: .init(statusCode: -1, data: Data()))
            .sink { [self] response in
                do {
                    let responseModel = try response.map(ResponseModel<RoomResponse>.self)
                    let model = RoomModel(model: responseModel.result)
                    roomType = model.type
                    isHost = model.isHost
                    models = model.comments
                    shareURL = model.shareURL
                    roomTitleText = model.title
                } catch {
                    Log(error)
                }
            }
            .store(in: &cancelBag)
    }
    
    func requestBookmark(delete: Bool = false) {
        requestBookmarkCancellable?.cancel()
        requestBookmarkCancellable = APIRequest.shared.requestBookmark(roomCode: roomCode, delete: delete)
            .replaceError(with: .init(statusCode: -1, data: Data()))
            .sink { response in
                if response.statusCode == 200 {
                    self.isBookmark = !self.isBookmark
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
    func requestRemoveCommentFromUser() {
        if let id = selectModel?.id {
            requestRemoveCommentCancellable?.cancel()
            requestRemoveCommentCancellable = APIRequest.shared.requestRemoveCommentFromUser(commentId: id)
                .replaceError(with: .init(statusCode: -1, data: Data()))
                .sink { [weak self] response in
                    if response.statusCode == 200 {
                        self?.removeModel(id: id)
                        self?.isCommentRemoved = true
                    }
                }
        }
    }

    /// 관리자가 게시물 삭제
    func requestRemoveCommentFromHost() {
        if let id = selectModel?.id {
            requestRemoveCommentCancellable?.cancel()
            requestRemoveCommentCancellable = APIRequest.shared.requestRemoveCommentFromHost(commentId: id)
                .replaceError(with: .init(statusCode: -1, data: Data()))
                .sink { [weak self] response in
                    if response.statusCode == 200 {
                        self?.removeModel(id: id)
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
}
