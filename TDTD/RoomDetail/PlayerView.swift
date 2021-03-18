//
//  PlayerView.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/08.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var viewModel: RollingpaperViewModel
    @State private var processValue: Float = 0.3
    @State private var isPlay: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
            VStack {
                HStack {
                    Text(viewModel.selectModel.nickname)
                        .font(Font.uhBeeCustom(14, weight: .bold))
                        .foregroundColor(Color("grayscale_1"))
                        .padding(8)
                        .background(
                            Capsule(style: .circular)
                                .fill(Color("beige_3"))
                        )
                        .frame(height: 32)
                    Spacer()
                    // TODO: - 추후 관리자인경우 모두 보이게 설정해야함
                    if !viewModel.selectModel.isMine {
                        Button(action: {
                            withAnimation {
                                viewModel.isReportRollingpaper = true
                            }
                        }, label: {
                            Image("ic_report_24")
                        })
                        Spacer().frame(width: 16)
                    }
                    if viewModel.selectModel.isMine {
                        Button(action: {
                            withAnimation {
                                viewModel.isRemoveRollingpaper = true
                            }
                        }, label: {
                            Image("ic_remove_24")
                        })
                        Spacer().frame(width: 16)
                    }
                    Button(action: {
                        withAnimation {
                            viewModel.isPresentPlayer = false
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
                            ProgressView(value: processValue)
                                .accentColor(Color("grayscale_1"))
                                .frame(height: 8)
                                .scaleEffect(x: 1, y: 1.8, anchor: .center)
                            Spacer().frame(height: 8)
                            HStack {
                                // FIXME:  추후 뷰모델과 연결후 플레이어 시간 넣어주기
                                Text("00:00").font(Font.uhBeeCustom(14, weight: .bold))
                                    .foregroundColor(Color("grayscale_3"))
                                Spacer()
                                Text("00:03").font(Font.uhBeeCustom(14, weight: .bold))
                                    .foregroundColor(Color("grayscale_3"))
                            }
                        }
                        .padding(.bottom, 24)
                        Spacer().frame(width: 16)
                        if isPlay {
                            Image("ic_speak_stop_32")
                                .resizable()
                                .frame(width: 40, height: 40)
                        } else {
                            Image("ic_speak_play_32")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }
                    .frame(height: 96)
                    .padding(.horizontal, 24)
                } else {
                    ScrollView {
                        Text(viewModel.selectModel.text ?? "")
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


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
