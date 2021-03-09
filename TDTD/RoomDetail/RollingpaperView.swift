//
//  RollingpaperView.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/05.
//

import SwiftUI

struct RollingpaperView: View {
    @ObservedObject var viewModel: RollingpaperViewModel
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
                    stickerView()
                    playerView()
                }
                .background(Color("beige_1"))
                .ignoresSafeArea(edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                .navigationBarItems(leading: Button(action: {
                    
                }, label: {
                    NavigationItemView(name: "ic_arrow_left_24")
                }),
                trailing: Button(action: {
                    
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
            .onAppear {
                UINavigationBar.appearance().barTintColor =  UIColor(named: "beige_1")
                UINavigationBar.appearance().shadowImage = UIImage()
            }
            alertView()
        }
    }
    
    @ViewBuilder
    private func stickerView() -> some View {
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
}

struct RollingpaperView_Previews: PreviewProvider {
    static var previews: some View {
        RollingpaperView(viewModel: RollingpaperViewModel())
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
