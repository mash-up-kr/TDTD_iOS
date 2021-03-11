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
    private let verticalPadding: CGFloat = 24
    @State private var nickname: String = ""
    @State private var contentText: String = ""
    @State private var isShowToast: Bool = false
    @State private var toastMessage: String = ""
    
    var body: some View {
        ZStack {
            Color("beige_1").ignoresSafeArea()
            VStack {
                VStack {
                    HStack {
                        SubTitle(text: "닉네임")
                        Spacer()
                        SubTitle(text: "0/12")
                    }
                    // FIXME:- 나중에 제가 고치겠습니당 :)
                    //                FocusTextFieldView(text: $nickname)
                    //                    .environmentObject(viewModel)
                    TextField("", text: $nickname) { onEditing in
                        viewModel.isEditing = onEditing
                        if !onEditing {
                            if nickname.isEmpty {
                                viewModel.model.nickname = nil
                            } else {
                                viewModel.model.nickname = nickname
                            }
                        }
                    }
                    .disableAutocorrection(true)
                    HStack {
                        SubTitle(text: viewModel.subTitle)
                        Spacer()
                    }
                    writeBodyView(type: viewModel.model.mode)
                }
                Spacer()
                bannerView()
                bottomButtonView()
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .toast(isShowing: $isShowToast, title: Text(toastMessage), hideAfter: 3)
            .hideKeyboard()
        }
    }
    
    @ViewBuilder
    private func writeBodyView(type: WriteMode) -> some View {
        if type == .text {
            FocusTextView(text: $contentText, placeholder: "남기고 싶은 말을 써주세요!") { onEditing in
                viewModel.isEditing = onEditing
                if contentText.isEmpty {
                    viewModel.model.message = nil
                } else {
                    viewModel.model.message = contentText
                }
            }
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color("beige_2"))
                ZStack {
                    if !viewModel.model.isEmptyData {
                        HStack {
                            VStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 29)
                                        .fill(Color("beige_3"))
                                        .frame(width: 48, height: 40)
                                    Button(action: {
                                        viewModel.reset()
                                    }, label: {
                                        Image("ic_restart_24")
                                    })
                                }
                                Text("다시녹음할래")
                                    .font(Font.uhBeeCustom(16, weight: .bold))
                                    .foregroundColor(Color("grayscale_3"))
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
                                .foregroundColor(Color("grayscale_2"))
                            Button(action: {
                                viewModel.recordButtonClick()
                            }, label: {
                                Image(uiImage: viewModel.recordImage!)
                                    .padding(8)
                                    .frame(width: 80, height: 80)
                            })
                            Text(viewModel.recordDescription)
                                .font(Font.uhBeeCustom(16, weight: .bold))
                                .foregroundColor(Color( "grayscale_3"))
                        }
                        Spacer()
                    }
                }
            }
            .frame(height: 184)
        }
    }
    
    @ViewBuilder
    private func bannerView() -> some View {
        if !viewModel.isEditing {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("beige_3"))
                .overlay(
                    Image("banner")
                )
                .frame(height: 96)
        }
    }
    
    @ViewBuilder
    private func bottomButtonView() -> some View {
        HStack {
            Button(action: {
                
            }, label: {
                Text("취소")
            })
            .buttonStyle(RoundButtonStyle(style: .light))
            Button(action: {
                if viewModel.model.nickname?.isEmpty ?? true {
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
                    viewModel.requestWriteComment()
                }
            }, label: {
                Text("완료")
            })
            .buttonStyle(RoundButtonStyle(style: .dark))
        }
        .padding(.top, horizontalPadding)
    }
}

struct RollingpagerWriteView_Previews: PreviewProvider {
    static var previews: some View {
        RollingpaperWriteView(viewModel: RollingpaperWriteViewModel(roomCode: "1", mode: .text))
    }
}
