//
//  CreateRoomView.swift
//  TDTD
//
//  Created by juhee on 2021/02/27.
//

import SwiftUI


struct CreateRoomView: View {

    @StateObject var viewModel: CreateRoomViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("beige_1"))
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                TextFieldFormItem(text: Binding(get: {
                    self.viewModel.title
                }, set: {
                    self.viewModel.title = $0
                }), title: "롤링페이퍼 방 이름", max: 35, placeholder: "방 이름을 적어주세요")
                    .padding(.bottom, 32)
                SelectRoomTypeView()
                Spacer()
                Button("방 만들기", action: {
                    self.viewModel.createRoom()
                })
                .buttonStyle(RoundButtonStyle(style: .dark))
            }
            .padding(16)
        }
        .environmentObject(viewModel)
    }
    
}

struct CreateRoomView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoomView(viewModel: CreateRoomViewModel())
    }
}
