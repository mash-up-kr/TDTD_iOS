//
//  RollingpagerWriteView.swift
//  TDTD
//
//  Created by 남수김 on 2021/02/27.
//

import SwiftUI
import UIKit

struct RollingpaperWriteView: View {
    @StateObject var viewModel: RollingpaperWriteViewModel
    private let horizontalPadding: CGFloat = 16
    private let verticalPadding: CGFloat = 24
    @State private var isShowToast: Bool = false
    @State private var toastMessage: String = ""
    @State private var isWrite: Bool = false
    
    var body: some View {
        ZStack {
            Color("beige_1").ignoresSafeArea()
            VStack {
                VStack {
                    TextFieldFormItem(text: Binding(get: { (viewModel.model.nickname ?? "") },
                                                    set: { viewModel.model.nickname = $0 }),
                                      isWrite: $isWrite,
                                      title: "닉네임",
                                      max: 12,
                                      placeholder: "닉네임을 입력해주세요")
                        .disableAutocorrection(true)
                    HStack {
                        SubTitle(text: viewModel.subTitle)
                        Spacer()
                    }
                    writeBodyView(type: viewModel.model.roomType)
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
    private func writeBodyView(type: RoomType) -> some View {
        if type == .text {
            ZStack {
                FocusTextView(text: Binding(get: { (viewModel.model.message ?? "") },
                                            set: { viewModel.model.message = $0 }),
                              isWrite: $isWrite,
                              placeholder: "남기고 싶은 말을 써주세요!")
            }.frame(height: 184)
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
        if !isWrite {
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
                    if viewModel.model.roomType == .text {
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
        RollingpaperWriteView(viewModel: RollingpaperWriteViewModel(roomCode: "1", roomType: .text))
    }
}
