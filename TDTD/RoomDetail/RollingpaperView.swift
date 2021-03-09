//
//  RollingpaperView.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/05.
//

import SwiftUI

struct RollingpaperView: View {
    let viewModel: RollingpaperViewModel
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
        NavigationView {
            ZStack {
                ScrollView {
                    let columns = [GridItem(.flexible()),
                                   GridItem(.flexible()),
                                   GridItem(.flexible())]
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(viewModel.models.indices, id: \.self) { index in
                            randomImage(isSelect: false)
                                .onTapGesture {
                                    if viewModel.selectIndex == index {
                                        viewModel.selectIndex = nil
                                        isTap = false
                                    } else {
                                        viewModel.selectIndex = index
                                        isTap = true
                                    }
                                }
                                .offset(x: randomHorizontalSpacing, y: randomVerticalSpacing)
                                .rotationEffect(Angle(degrees: randomRotate))
                                .frame(height: 146)
                            
                        }
                    }
                    .padding(16)
                }
                if isTap {
                    VStack{
                        Spacer()
                        PlayerView(model: viewModel.selectModel)
                            
                            .transition(.slide)
                    }
                }
            }
            .background(Color("beige_1"))
            .ignoresSafeArea(edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
            .navigationBarItems(leading: Button(action: {
                
            }, label: {
                RoundedRectangle(cornerRadius: 13)
                    .fill(Color("beige_3"))
                    .frame(width: 40, height: 40)
                    .overlay(Image("ic_arrow_left_24"))
            }),
            trailing: Button(action: {
                
            }, label: {
                RoundedRectangle(cornerRadius: 13)
                    .fill(Color("beige_3"))
                    .frame(width: 40, height: 40)
                    .overlay(Image("ic_leave_24"))
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
