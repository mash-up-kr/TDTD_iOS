//
//  RollingpaperView.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/05.
//

import SwiftUI

struct RollingpaperView: View {
    let model: RollingpaperModel
    @State private var isTap: Bool = false
    var randomHorizontalSpacing: CGFloat {
        CGFloat(Int.random(in: -15...16))
    }
    var randomVerticalSpacing: CGFloat {
        CGFloat(Int.random(in: -8...8))
    }
    var randomRotate: Double {
        Double(Int.random(in: -10...10))
    }
    
    func randomImage(isSelect: Bool) -> Image {
        if isSelect {
            return CharacterAsset.select(color: CharacterAsset.randomColor).image
        } else {
            return CharacterAsset.normal(color: CharacterAsset.randomColor).image
        }
    }
    
    var body: some View {
        ScrollView {
            let columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(0..<16, id: \.self) { _ in
                    randomImage(isSelect: false)
                        .onTapGesture {
                            isTap.toggle()
                        }
                        .offset(x: randomHorizontalSpacing, y: randomVerticalSpacing)
                        .rotationEffect(Angle(degrees: randomRotate))
                        .frame(height: 146)
                    if isTap {
                        PlayerView(nickname: model.nickname, roomType: model.roomType)
                    }
                }
            }
            .padding(16)
        }
    }
}

struct RollingpaperView_Previews: PreviewProvider {
    static var previews: some View {
        RollingpaperView(model: RollingpaperModel(id: "1",
                                                  nickname: "tts",
                                                  duration: nil,
                                                  voice: nil,
                                                  text: "가나다라마바사"))
    }
}

enum CharacterAsset {
    case normal(color: CharacterAsset.Color), select(color: CharacterAsset.Color)
    
    enum Color: String, CaseIterable {
        case red = "img_character_1_center_"
        case yellow = "img_character_2_center_"
        case green = "img_character_3_center_"
        case blue = "img_character_4_center_"
        case lavender = "img_character_5_center_"
        case lightPink = "img_character_6_center_"
        case lightGreen = "img_character_7_center_"
    }
    
    var image: Image {
        switch self {
        case .normal(let color):
            return Image("\(color.rawValue)default")
        case .select(let color):
            return Image("\(color.rawValue)select")
        }
    }
    
    static var randomColor: CharacterAsset.Color {
        CharacterAsset.Color.allCases.randomElement() ?? .lightPink
    }
}
