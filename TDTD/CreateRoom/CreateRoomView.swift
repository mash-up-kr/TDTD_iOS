//
//  CreateRoomView.swift
//  TDTD
//
//  Created by juhee on 2021/02/27.
//

import SwiftUI


struct CreateRoomView: View {

    @ObservedObject var viewModel: CreateRoomViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            TextFieldFormItem(viewModel: FocusTextFieldViewModel(title: "롤링페이퍼 방 이름", text: self.viewModel.room.title, placeholder: "방 이름을 적어주세요", max: 35))
                .padding(.bottom, 32)
            SelectRoomTypeView(selectedType: Binding<RoomType>(
                get: {
                    self.viewModel.room.type
                }, set: {
                    self.viewModel.updateRoom(type: $0)
                }
            ))
            Spacer()
            Button("방 만들기", action: {
                self.viewModel.createRoom()
            })
            .buttonStyle(RoundButtonStyle(style: .dark))
        }
        .padding(16)
    }
    
}

struct CreateRoomView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoomView(viewModel: CreateRoomViewModel())
    }
}
