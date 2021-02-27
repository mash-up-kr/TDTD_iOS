//
//  RollingpagerWriteView.swift
//  TDTD
//
//  Created by 남수김 on 2021/02/27.
//

import SwiftUI

struct RollingpaperWriteView: View {
    let viewModel: RollingpaperWriteViewModel
    private let leadingPadding: CGFloat = 16
    private let radius: CGFloat = 16
    
    var body: some View {
        VStack {
            HStack {
                Text("닉네임")
                Spacer()
                Text("0/12")
            }
            FocusTextFieldView("닉네임 쓰는칸")
            HStack {
                Text("남기고 싶은 말을 속삭여주세요!")
                Spacer()
            }
            if viewModel.mode == .text {
                FocusTextView("텍스트뷰\n이빈다")
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: radius)
                        .fill(Color(UIColor(named: "beige_2")!))
                    HStack {
                        Image(systemName: "timer")
                        VStack {
                            
                            Text("최대 1분")
                            Image(systemName: "timer")
                                .padding(8)
                                .frame(width: 80, height: 80)
                            Text("버튼을 눌러 녹음하기")
                        }.layoutPriority(1)
                    }
                }
            }
        }.padding(leadingPadding)
    }
}


struct RollingpagerWriteView_Previews: PreviewProvider {
    static var previews: some View {
        RollingpaperWriteView(viewModel: RollingpaperWriteViewModel(mode: .voice))
    }
}
