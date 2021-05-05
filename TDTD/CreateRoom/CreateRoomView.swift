//
//  CreateRoomView.swift
//  TDTD
//
//  Created by juhee on 2021/02/27.
//

import SwiftUI


struct CreateRoomView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject var viewModel: CreateRoomViewModel
    @State private var isWrite: Bool = false
    @Binding var presentCreatRoom: Bool
    
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
                }),
                isWrite: $isWrite,
                title: "롤링페이퍼 방 이름", max: 35, placeholder: "방 이름을 적어주세요")
                    .padding(.bottom, 32)
                SelectRoomTypeView()
                Spacer()
                Button("방 만들기", action: {
                    self.viewModel.createRoom()
                })
                .buttonStyle(RoundButtonStyle(style: .dark))
            }
            .padding(16)
            .onReceive(viewModel.$isCreated) {
                if $0 {
                    presentCreatRoom = false
                    homeViewModel.roomType = viewModel.type
                    homeViewModel.roomCode = viewModel.newRoomCode
                    homeViewModel.objectWillChange.send()
                }
            }
        }
        .environmentObject(viewModel)
    }
    
}
//
//struct CreateRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateRoomView(viewModel: CreateRoomViewModel(isPresented: .constant(true)))
//    }
//}
