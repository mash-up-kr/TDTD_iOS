//
//  ModifyRoomTitleView.swift
//  TDTD
//
//  Created by 남수김 on 2021/07/18.
//

import SwiftUI

struct ModifyRoomTitleView: View {
    @EnvironmentObject var viewModel: RollingpaperViewModel
    @State private var title: String = ""
    @State private var isWrite: Bool = false
    @Binding var isPresent: Bool
    @Binding var isToast: Bool
    @State private var isFail: Bool = false
    
    var curTitle: String
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.55)
                .onTapGesture {
                    isPresent = false
                }
            VStack {
                Spacer()
                ColorPallete.beige(1).color
                    .overlay(
                        VStack {
                            TextFieldFormItem(text: $title,
                                              isWrite: $isWrite,
                                              title: "방 이름 바꾸기",
                                              max: 35,
                                              placeholder: curTitle)
                                .disableAutocorrection(true)
                            Spacer(minLength: 40)
                            Button(action: {
                                viewModel.requestModifyRoomTitle(title: title)
                                isWrite = false
                            }, label: {
                                Text("확인")
                            })
                            .disabled(title.isEmpty)
                            .buttonStyle(RoundButtonStyle(style: .dark))
                            .opacity(title.isEmpty ? 0.5 : 1)
                        }
                        .padding([.leading, .trailing, .bottom], 16)
                        .padding(.top, 24)
                    )
                    .frame(height: 204)
                    .cornerRadius(radius: 24, cornerStyle: [.topLeft, .topRight])
            }
            failAlert()
        }
        .ignoresSafeArea(.container, edges: [.bottom, .top])
        .onReceive(viewModel.$isModifyRoomTitleResponseCode) { stateCode in
            switch stateCode {
            case 0: break
            case 200:
                isToast = true
                isPresent = false
            default:
                isFail = true
            }
        }
    }
    
    @ViewBuilder
    private func failAlert() -> some View {
        if isFail {
            AlertView(title: "오류",
                      msg: "다시 시도해주세요 😭",
                      rightTitle: "확인",
                      rightAction: {
                        isFail = false
                      })
        }
    }
}

struct ModifyRoomTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyRoomTitleView(isPresent: Binding.constant(true), isToast: .constant(true), curTitle: "현재방제목은?")
    }
}
