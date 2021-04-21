//
//  PlayerView.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/08.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var viewModel: RollingpaperViewModel
    @Binding var isRemoveRollingpaper: Bool
    @Binding var isReportRollingpaper: Bool
    @Binding var isPresentPlayer: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
            VStack {
                HStack {
                    Text(viewModel.selectModel?.nickname ?? "")
                        .font(Font.uhBeeCustom(14, weight: .bold))
                        .foregroundColor(Color("grayscale_1"))
                        .padding(8)
                        .background(
                            Capsule(style: .circular)
                                .fill(Color("beige_3"))
                        )
                        .frame(height: 32)
                    Spacer()
                    if !(viewModel.selectModel?.isMine ?? false) {
                        Button(action: {
                            withAnimation {
                                isReportRollingpaper = true
                            }
                        }, label: {
                            Image("ic_report_24")
                        })
                        Spacer().frame(width: 16)
                    }
                    if (viewModel.selectModel?.isMine ?? false) || viewModel.isHost {
                        Button(action: {
                            withAnimation {
                                isRemoveRollingpaper = true
                            }
                        }, label: {
                            Image("ic_remove_24")
                        })
                        Spacer().frame(width: 16)
                    }
                    Button(action: {
                        withAnimation {
                            isPresentPlayer = false
                            viewModel.playerReset()
                        }
                    }, label: {
                        Image("ic_close_24")
                    })
                }
                Spacer().frame(height: 20)
                playerViewWithType(roomType: viewModel.roomType)
            }
            .padding(.top, 24)
            .padding(.bottom, 34)
            .padding(.horizontal, 24)
        }
        .frame(height: viewModel.roomType == .voice ? 202 : 290)
        .cornerRadius(radius: 24, cornerStyle: [.topLeft, .topRight])
        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 6)
        .onAppear {
            viewModel.curPlayTime = "00:00"
            viewModel.totalPlayTime = "00:00"
        }
    }
    
    func playerViewWithType(roomType: RoomType) -> some View {
        ZStack {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color("beige_2"))
                if roomType == .voice {
                    HStack {
                        VStack {
                            Spacer().frame(height: 40)
                            ProgressView(value: viewModel.progressRate)
                                .accentColor(Color("grayscale_1"))
                                .frame(height: 8)
                                .scaleEffect(x: 1, y: 1.8, anchor: .center)
                            Spacer().frame(height: 8)
                            HStack {
                                Text(viewModel.curPlayTime)
                                    .font(Font.uhBeeCustom(14, weight: .bold))
                                    .foregroundColor(Color("grayscale_3"))
                                Spacer()
                                Text(viewModel.totalPlayTime)
                                    .font(Font.uhBeeCustom(14, weight: .bold))
                                    .foregroundColor(Color("grayscale_3"))
                            }
                        }
                        .padding(.bottom, 24)
                        Spacer().frame(width: 16)
                        Button {
                            viewModel.speackButtonTouchUpInside()
                        } label: {
                            Image(viewModel.isPlay ? "ic_speak_stop_32" : "ic_speak_play_32")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }
                    .frame(height: 96)
                    .padding(.horizontal, 24)
                } else {
                    ScrollView {
                        Text(viewModel.selectModel?.text ?? "")
                            .font(Font.uhBeeCustom(16, weight: .bold))
                            .foregroundColor(Color("grayscale_1"))
                        
                    }
                    .padding(16)
                }
            }
        }
        .frame(height: roomType == .voice ? 96 : 184)
    }
}
