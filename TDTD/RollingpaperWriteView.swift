//
//  RollingpagerWriteView.swift
//  TDTD
//
//  Created by 남수김 on 2021/02/27.
//

import SwiftUI

struct RollingpaperWriteView: View {
    @ObservedObject var viewModel: RollingpaperWriteViewModel
    private let horizontalPadding: CGFloat = 16
    private let verticalPadding: CGFloat = 23
    @State private var isDisableComplete: Bool = true
    @State private var nickName: String = ""
    @State private var contentText: String = ""
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("닉네임")
                    Spacer()
                    Text("0/12")
                }
                FocusTextFieldView(text: $nickName)
                    .environmentObject(viewModel)
                HStack {
                    Text("남기고 싶은 말을 속삭여주세요!")
                    Spacer()
                }
                if viewModel.mode == .text {
                    FocusTextView(text: $contentText)
                        .environmentObject(viewModel)
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(UIColor(named: "beige_2")!))
                        ZStack {
                            if viewModel.isExistRecord {
                                HStack {
                                    VStack {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 29)
                                                .fill(Color(UIColor(named: "beige_3")!))
                                                .frame(width: 48, height: 40)
                                            Button(action: {
                                                viewModel.reset()
                                            }, label: {
                                                Image(uiImage: UIImage(named: "ic_restart_24")!)
                                            })
                                        }
                                        Text("다시녹음할래")
                                            .font(Font.uhBeeCustom(16, weight: .bold))
                                            .foregroundColor(Color(UIColor(named: "grayscale_3")!))
                                    }
                                    .padding(.leading, 47.5)
                                    Spacer()
                                }
                            }
                            HStack {
                                Spacer()
                                VStack {
                                    Text("최대 1분")
                                        .font(Font.uhBeeCustom(20, weight: .bold))
                                        .foregroundColor(Color(UIColor(named: "grayscale_2")!))
                                    Button(action: {
                                        viewModel.recordButtonClick()
                                    }, label: {
                                        Image(uiImage: viewModel.recordImage!)
                                            .padding(8)
                                            .frame(width: 80, height: 80)
                                    })
                                    Text(viewModel.recordDescription)
                                        .font(Font.uhBeeCustom(16, weight: .bold))
                                        .foregroundColor(Color(UIColor(named: "grayscale_3")!))
                                }
                                Spacer()
                            }
                        }
                    }
                    .frame(height: 184)
                }
                Spacer()
            }
            ZStack {
                if !viewModel.isEditing {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(UIColor(named: "beige_2")!))
                        .overlay(
                            Image(uiImage: UIImage(named: "banner")!)
                                .resizable()
                        )
                }
            }
            .frame(height: 129)
            HStack {
                Button(action: {
                    
                }, label: {
                    Text("취소")
                })
                .buttonStyle(RoundButtonStyle(style: .light))
                if isDisableComplete {
                    Button(action: {
                        
                    }, label: {
                        Text("완료")
                    })
                    .buttonStyle(RoundButtonStyle(style: .dark))
                    .opacity(0.5)
                } else {
                    Button(action: {
                        
                    }, label: {
                        Text("완료")
                    })
                    .buttonStyle(RoundButtonStyle(style: .dark))
                }
            }
            .padding(.vertical, horizontalPadding)
        }
        .padding(.horizontal, horizontalPadding)
    }
    
    private func checkComplete() {
//        if viewModel.mode == .text
//        if !nickName.isEmpty && viewModel.existRecord {
//        isDisableComplete = true
    }
}


struct RollingpagerWriteView_Previews: PreviewProvider {
    static var previews: some View {
        RollingpaperWriteView(viewModel: RollingpaperWriteViewModel(mode: .voice))
    }
}
