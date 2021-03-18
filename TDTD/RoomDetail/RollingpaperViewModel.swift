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
    var selectIndex: Int?
    var selectModel: RollingpaperModel {
        models[selectIndex!]
    }
    var mode: WriteMode
    let roomCode: String
    private var requestBookmarkCancellable: AnyCancellable?
    
    init(roomCode: String, mode: WriteMode) {
        self.roomCode = roomCode
        self.mode = mode
        testData()
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

// MARK:: - Debug용 추후 삭제예정

extension RollingpaperViewModel {
    func testData() {
        let test1 = RollingpaperModel(id: 1,
                                      isMine: true,
                                      nickname: "닉네임은 무엇인가",
                                      text: "하이루반가워요",
                                      voiceURL: nil,
                                      stickerColor: CharacterAsset.randomColor,
                                      stickerAngle: 10,
                                      createAt: Date())
        let test2 = RollingpaperModel(id: 2,
                                      isMine: false,
                                      nickname: "꾀꼬리",
                                      text: nil,
                                      voiceURL: "",
                                      stickerColor: CharacterAsset.randomColor,
                                      stickerAngle: 3,
                                      createAt: Date())
        models.append(test1)
        models.append(test2)
        models.append(test1)
        models.append(test2)
        models.append(test1)
        models.append(test2)
    }
}
