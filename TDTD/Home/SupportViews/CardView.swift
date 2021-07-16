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
    
    var roomSummary: RoomSummary
    
    var body: some View {
        VStack(spacing: 40) {
            HStack(spacing: 8) {
                Image(roomSummary.type == .record ? "badge_record" : "badge_text")
                Text(roomSummary.title ?? "")
                    .foregroundColor(.init("grayscale_1"))
                    .font(.uhBeeCustom(20, weight: .bold))
                    .lineLimit(2)
                Spacer(minLength: 16)
                if roomSummary.isHost {
                    Button(action: {}) {
                        Image("ic_crown_24")
                    }
                }
            }
            
            HStack(spacing: 8) {
                Text("만든 날짜")
                    .foregroundColor(.init("grayscale_2"))
                    .font(.uhBeeCustom(16, weight: .bold))
                Text((roomSummary.createdAt ?? "").convertSlashDate)
                    .foregroundColor(.init("grayscale_2"))
                    .font(.uhBeeCustom(14, weight: .bold))
                Spacer()
                Button(action: {
                }) {
                    roomSummary.isBookmark ? Image("ic_favorties_on_16") : Image("ic_favorties_off_16")
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
        CardView(roomSummary: RoomSummary(isHost: true, title: "이거슨 타이틀입니다.", roomCode: "", isBookmark: true, createdAt: nil, shareURL: nil, type: .record))
            .padding(.horizontal, 16)
    }
}
