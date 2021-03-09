//
//  RollingpaperViewModel.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/09.
//

import SwiftUI

final class RollingpaperViewModel: ObservableObject {
    @Published private(set) var models: [RollingpaperModel] = []
    var selectIndex: Int?
    var selectModel: RollingpaperModel {
        models[selectIndex!]
    }
    
    init() {
        testData()
    }
    
}

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
