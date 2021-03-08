//
//  RollingpaperView.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/05.
//

import SwiftUI

struct RollingpaperView: View {
    let model: RollingpaperModel
    @State private var isTap: Bool = true
    
    var body: some View {
        ZStack {
            Image("character")
                .onTapGesture {
                    isTap.toggle()
                }
            if isTap {
                PlayerView(nickName: model.nickName, roomType: .voice)
            }
        }
    }
}

struct RollingpaperView_Previews: PreviewProvider {
    static var previews: some View {
        RollingpaperView(model: RollingpaperModel(id: "1",
                                                  nickName: "tts",
                                                  duration: nil,
                                                  voice: nil,
                                                  text: "가나다라마바사"))
    }
}

struct RollingpaperModel: Identifiable {
    let id: String
    let nickName: String
    let duration: String?
    let voice: Data?
    let text: String?
    
    init(id: String, nickName: String, duration: String? = nil, voice: Data? = nil, text: String? = nil) {
        self.id = id
        self.nickName = nickName
        self.duration = duration
        self.voice = voice
        self.text = text
    }
}
