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
    @Published var isRemoveRollingpaper: Bool = false
    @Published var isReportRollingpaper: Bool = false
    @Published var isPresentPlayer: Bool = false
    @Published var isBookmark: Bool = false
    @Published var isHost: Bool = false
    @Published var roomType: RoomType = .none
    @Published var roomTitleText: String = ""
    var selectIndex: Int?
    var selectModel: RollingpaperModel {
        models[selectIndex!]
    }
    let roomCode: String
    private var requestBookmarkCancellable: AnyCancellable?
    private var cancelBag = Set<AnyCancellable>()
    private var shareURL: String = ""
    
    init(roomCode: String, roomType: RoomType) {
        self.roomCode = roomCode
        self.roomType = roomType
    }
    
    init(roomCode: String) {
        self.roomCode = roomCode
    }
    
    func requestRoomDetailInfo() {
        APIRequest.shared.requestRoomDetail(roomCode: roomCode)
            .replaceError(with: .init(statusCode: -1, data: Data()))
            .sink { [self] response in
                do {
                    let responseModel = try response.map(RoomResponse.self)
                    let model = RoomModel(model: responseModel)
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
                }
            }
    }
}
