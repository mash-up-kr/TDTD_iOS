//
//  RollingpagerWriteView.swift
//  TDTD
//
//  Created by 남수김 on 2021/02/27.
//

import SwiftUI
import UIKit

struct RollingpaperWriteView: View {
    @ObservedObject var viewModel: RollingpaperWriteViewModel
    private let horizontalPadding: CGFloat = 16
    private let verticalPadding: CGFloat = 23
    @State private var nickName: String = ""
    @State private var contentText: String = ""
    @State private var isShowToast: Bool = false
    @State private var toastMessage: String = ""
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("닉네임")
                    Spacer()
                    Text("0/12")
                }
                // FIXME:- 나중에 제가 고치겠습니당 :)
//                FocusTextFieldView(text: $nickName)
//                    .environmentObject(viewModel)
                TextField("", text: $nickName) { isEditing in
                    viewModel.isEditing = isEditing
                    if !isEditing {
                        viewModel.model.nickName = nickName
                    }
                }
                HStack {
                    Text("남기고 싶은 말을 속삭여주세요!")
                    Spacer()
                }
                if viewModel.model.mode == .text {
                    FocusTextView(text: $contentText) { onEditing in
                        if !onEditing {
                            viewModel.model.message = contentText
                        }
                    }
                    .environmentObject(viewModel)
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(UIColor(named: "beige_2")!))
                        ZStack {
                            if !viewModel.model.isEmptyData {
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
                                    Text(viewModel.timerString)
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
                        .fill(Color(UIColor(named: "beige_3")!))
                        .overlay(
                            Image(uiImage: UIImage(named: "banner")!)
                        )
                }
            }
            .frame(height: 96)
            HStack {
                Button(action: {
                    
                }, label: {
                    Text("취소")
                })
                .buttonStyle(RoundButtonStyle(style: .light))
                Button(action: {
                    if viewModel.model.nickName?.isEmpty ?? true {
                        toastMessage = "닉네임을 입력해주세요!"
                        isShowToast = true
                    } else if viewModel.model.isEmptyData {
                        if viewModel.model.mode == .text {
                            toastMessage = "남기고 싶은 말을 써주세요!"
                        } else {
                            toastMessage = "남기고 싶은 말을 속삭여주세요!"
                        }
                        isShowToast = true
                    } else {
                        
                    // TODO: - 완료후 화면으로 넘어가기
                        
                    }
                    
                }, label: {
                    Text("완료")
                })
                .buttonStyle(RoundButtonStyle(style: .dark))
            }
            .padding(.vertical, horizontalPadding)
        }
        .padding(.horizontal, horizontalPadding)
        .toast(isShowing: $isShowToast, title: Text(toastMessage), hideAfter: 3)
        .hideKeyboard()
    }
}

struct RollingpagerWriteView_Previews: PreviewProvider {
    static var previews: some View {
        RollingpaperWriteView(viewModel: RollingpaperWriteViewModel(mode: .voice))
    }
}
