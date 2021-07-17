//
//  ModifyRoomTitleView.swift
//  TDTD
//
//  Created by 남수김 on 2021/07/18.
//

import SwiftUI

struct ModifyRoomTitleView: View {
    @State private var title: String = "2"
    @State private var isWrite: Bool = false
    var curTitle: String
    
    var body: some View {
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
                        isWrite = false
                    }, label: {
                        Text("확인")
                    })
                    .buttonStyle(RoundButtonStyle(style: .dark))
                    .opacity(title.isEmpty ? 0.5 : 1)
                }
                .padding([.leading, .trailing, .bottom], 16)
                .padding(.top, 24)
            )
            .frame(height: 204)
            .cornerRadius(radius: 24, cornerStyle: [.topLeft, .topRight])
    }
}

struct ModifyRoomTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyRoomTitleView(curTitle: "현재방제목은?")
    }
}
