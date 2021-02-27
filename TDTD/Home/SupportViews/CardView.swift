//
//  CardView.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/27.
//

import SwiftUI

struct CardView: View {
    @State private var isFavorite = true
    @State private var isHost = true
    
    var body: some View {
        VStack(spacing: 40) {
            HStack() {
                Text("이거슨 타이틀입니다아아아아아아아ㅏ아앙.")
                    .foregroundColor(.init("grayscale_1"))
                    .font(.uhBeeCustom(20, weight: .bold))
                    .lineLimit(2)
                Spacer(minLength: 16)
                if isHost {
                    Button(action: {}) {
                        Image("ic_crown_24")
                    }
                }
            }
            
            HStack(spacing: 8) {
                Text("만든 날짜")
                    .foregroundColor(.init("grayscale_2"))
                    .font(.uhBeeCustom(16, weight: .bold))
                Text("0000/00/00")
                    .foregroundColor(.init("grayscale_2"))
                    .font(.uhBeeCustom(14, weight: .bold))
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    isFavorite ? Image("ic_favorties_on_16") : Image("ic_favorties_off_16")
                }
                .padding(.trailing, 4)
            }
        }
        .padding(16)
        .background(Color.init("beige_2"))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.init("beige_3"), lineWidth: 1)
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
            .padding(.horizontal, 16)
    }
}
