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
                PlayerView(nickName: model.nickName)
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

struct PlayerView: View {
    @State private var processValue = 0.3
    let nickName: String
    
    var body: some View {
        ZStack {
            // FIXME: - 추후 이미지로 교체 예정인 배경
            Capsule(style: .circular)
                .fill(Color.white)
            Capsule(style: .circular)
                .stroke()
                .foregroundColor(Color("beige_3"))
            VStack {
                Text(nickName)
                    .font(Font.uhBeeCustom(14, weight: .bold))
                    .foregroundColor(Color("grayscale_1"))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(
                        Capsule(style: .circular)
                            .fill(Color("beige_3"))
                    )
                    .frame(height: 24)
                Spacer()
            }
            HStack {
                Image("ic_speak_play_32")
                    .resizable()
                    .frame(width: 40, height: 40)
                Spacer().frame(width: 16)
                VStack {
                    Spacer().frame(height: 12)
                    ProgressView(value: processValue)
                        .accentColor(Color("grayscale_1"))
                        .frame(width: 120, height: 8)
                    HStack {
                        Text("00:00").font(Font.uhBeeCustom(14, weight: .bold))
                            .foregroundColor(Color("grayscale_3"))
                        Spacer()
                        Text("00:03").font(Font.uhBeeCustom(14, weight: .bold))
                            .foregroundColor(Color("grayscale_3"))
                    }
                }
            }
            .padding(24)
        }
        .frame(width: 224, height: 96)
    }
}
