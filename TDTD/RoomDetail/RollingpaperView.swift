//
//  RollingpaperView.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/05.
//

import SwiftUI

struct RollingpaperView: View {
    @ObservedObject var viewModel: RollingpaperViewModel
    @State private var isPresentWriteView: Bool = false
    // FIXME: - 추후 통신후 호스트 변수위치 수정가능
    @State private var isHost: Bool = true
    // FIXME: - 추후 방만들기 직후 변수위치 수정가능
    @State private var isMakeRoom: Bool = false
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
        ZStack {
            NavigationView {
                ZStack {
                    Color("beige_1").ignoresSafeArea()
                    bottomTrailingOptionButtonView()
                    stickerGridView()
                    playerView().ignoresSafeArea()
                }
                .navigationBarItems(leading: Button(action: {
                    print("이전 화면으로!")
                }, label: {
                    NavigationItemView(name: "ic_arrow_left_24")
                }),
                trailing: Button(action: {
                    print("방 나가기!")
                }, label: {
                    NavigationItemView(name: "ic_leave_24")
                }))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("버튼 타이틀 간격 방제목").font(Font.uhBeeCustom(20, weight: .bold))
                    }
                }
            }
            .sheet(isPresented: $isPresentWriteView,
                   content: {
                    RollingpaperWriteView(viewModel: RollingpaperWriteViewModel(mode: viewModel.mode))
                   })
            .onAppear {
                UINavigationBar.appearance().barTintColor =  UIColor(named: "beige_1")
                UINavigationBar.appearance().shadowImage = UIImage()
            }
            alertView()
        }
    }
    
    @ViewBuilder
    private func stickerGridView() -> some View {
        if viewModel.models.isEmpty {
            emptyView()
                .offset(x: 0, y: -30)
        } else {
            ScrollView {
                let columns = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(viewModel.models.indices, id: \.self) { index in
                        randomImage(isSelect: false)
                            .onTapGesture {
                                if !viewModel.isPresentPlayer {
                                    viewModel.selectIndex = index
                                }
                                withAnimation {
                                    viewModel.isPresentPlayer.toggle()
                                }
                            }
                            .offset(x: randomHorizontalSpacing, y: randomVerticalSpacing)
                            .rotationEffect(Angle(degrees: randomRotate))
                            .frame(height: 146)
                    }
                }
                .padding(16)
            }
        }
    }
    
    @ViewBuilder
    private func emptyView() -> some View {
        if isHost {
            if isMakeRoom {
                VStack(spacing: 24) {
                    PlaceholderView(text: "오른쪽 상단 더보기 버튼을 눌러서\n초대링크를 보낼수있어요!")
                        .multilineTextAlignment(.center)
                    Button(action: {
                        print("초대링크 보내기!")
                    }, label: {
                        Text("초대링크 보내기")
                    })
                    .buttonStyle(RoundButtonStyle(style: .dark))
                    .frame(width: 148)
                }
            } else {
                PlaceholderView(text: "아직 아무도 답장을 하지 않았어요\n다른 사람에게도 초대링크를 보내보세요!")
                    .multilineTextAlignment(.center)
            }
        } else {
            PlaceholderView(text: "친구에게 마음을 속삭여보세요!")
        }
    }
    
    @ViewBuilder
    private func playerView() -> some View {
        if viewModel.isPresentPlayer {
            VStack {
                Spacer()
                PlayerView()
                    .environmentObject(viewModel)
                
            }
            .transition(AnyTransition.move(edge: .bottom))
        }
    }
    
    @ViewBuilder
    private func alertView() -> some View {
        if viewModel.isReportRollingpaper {
            AlertView(title: "답장 신고하기",
                      msg: "정말 답장을 신고하시겠어요?🚨",
                      leftTitle: "신고할래요",
                      leftAction: {
                        print("신고!")
                        viewModel.isReportRollingpaper = false
                      },
                      rightTitle: "안할래요!",
                      rightAction: {
                        viewModel.isReportRollingpaper = false
                      })
        }
        if viewModel.isRemoveRollingpaper {
            AlertView(title: "답장 삭제하기",
                      msg: "정말 답장을 삭제하시겠어요?😭",
                      leftTitle: "삭제할래요",
                      leftAction: {
                        print("삭제!")
                        viewModel.isRemoveRollingpaper = false
                      },
                      rightTitle: "안할래요!",
                      rightAction: {
                        viewModel.isRemoveRollingpaper = false
                      })
        }
    }
    
    @ViewBuilder
    private func bottomTrailingOptionButtonView() -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        print("즐겨찾기!")
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 18)
                                .fill(Color("beige_2"))
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color("beige_3"), lineWidth: 1)
                            Image("icfavorties_off_32")
                        }.frame(width: 56, height: 56)
                    })
                    Spacer().frame(height: 24)
                    Button(action: {
                        isPresentWriteView = true
                    }, label: {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color("grayscale_1"))
                            .frame(width: 56, height: 56)
                            .overlay(Image("ic_write_32"))
                    })
                }
            }
            .padding(.trailing, 16)
        }
        .padding(.bottom, 24)
    }
}

struct RollingpaperView_Previews: PreviewProvider {
    static var previews: some View {
        RollingpaperView(viewModel: RollingpaperViewModel(mode: .text))
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
