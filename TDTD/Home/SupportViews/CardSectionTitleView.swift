//
//  CardSectionTitleView.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/27.
//

import SwiftUI

struct CardSectionTitleView: View {
    @State private var isFavorite = false
    
    var body: some View {
        HStack {
            Text("롤링페이퍼 리스트")
                .font(.uhBeeCustom(16, weight: .bold))
                .foregroundColor(.init("grayscale_3"))
            Spacer()
            Button(action: {}, label: {
                HStack(spacing: 8) {
                    isFavorite ? Image("ic_checkBox_on_16") : Image("ic_checkBox_off_16")
                    Text("즐겨찾기")
                        .font(.uhBeeCustom(16, weight: .bold))
                        .foregroundColor(.init("grayscale_3"))
                }
            })
        }
    }
}

struct CardSectionTitleView_Previews: PreviewProvider {
    static var previews: some View {
        CardSectionTitleView()
            .padding()
    }
}
