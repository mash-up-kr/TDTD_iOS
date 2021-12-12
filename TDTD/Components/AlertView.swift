//
//  AlertView.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/08.
//

import SwiftUI

struct AlertView: View {
    var title: String
    var message: String
    var leftTitle: String? = nil
    var leftAction: (() -> Void)? = nil
    var rightTitle: String? = nil
    var rightAction: (() -> Void)? = nil
    
    init(title: String,
         msg: String,
         leftTitle: String? = nil,
         leftAction: (() -> Void)? = nil,
         rightTitle: String? = nil,
         rightAction: (() -> Void)? = nil) {
        self.title = title
        self.message = msg
        self.leftTitle = leftTitle
        self.rightTitle = rightTitle
        self.leftAction = leftAction
        self.rightAction = rightAction
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(Color.black.opacity(0.55))
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color("beige_2"))
                VStack {
                    SubTitle(text: title)
                    Spacer().frame(height: 8)
                    Text(message)
                        .font(Font.uhBeeCustom(16, weight: .bold))
                        .foregroundColor(Color("grayscale_2"))
                    Spacer().frame(height: 32)
                    HStack {
                        if let leftTitle = leftTitle {
                            Button(action: {
                                leftAction?()
                            }, label: {
                                Text(leftTitle)
                            })
                            .buttonStyle(RoundButtonStyle(style: .light, size: .small))
                        }
                        if let rightTitle = rightTitle {
                            Button(action: {
                                rightAction?()
                            }, label: {
                                Text(rightTitle)
                            })
                            .buttonStyle(RoundButtonStyle(style: .dark, size: .small))
                        }
                    }
                }
                .padding(.top, 24)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
            }
            .frame(width: 264, height: 156)
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(title: "답장 삭제하기",
                  msg: "정말 답장을 삭제하시겠어요?😭",
                  leftTitle: "삭제할래요",
                  leftAction: {
                    // 왼쪽버튼시 동작
                  },
                  rightTitle: "안할래요!",
                  rightAction: {
                    // 오른쪽버튼시 동작
                  })
    }
}
