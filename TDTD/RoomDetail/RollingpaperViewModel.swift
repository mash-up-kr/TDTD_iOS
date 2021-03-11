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
    
    var selectIndex: Int?
    var selectModel: RollingpaperModel {
        models[selectIndex!]
    }
    var cancellable: AnyCancellable?
    var mode: WriteMode
    
    init(mode: WriteMode) {
        self.mode = mode
//        testData()
        cancellable = self.$isRemoveRollingpaper.sink {
            print($0)
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
