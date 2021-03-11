//
//  SelectRoomTypeView.swift
//  TDTD
//
//  Created by juhee on 2021/02/28.
//

import SwiftUI

struct SelectRoomTypeView: View {
    
    @EnvironmentObject var viewModel: CreateRoomViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            SubTitle(text: "롤링페이퍼 작성 방법")
            HStack {
                RoomTypeButton(type: .voice, selectedType: $viewModel.type)
                RoomTypeButton(type: .text, selectedType: $viewModel.type)
            }
        }
    }
}

struct SelectRoomTypeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectRoomTypeView()
            .environmentObject(CreateRoomViewModel())
    }
}
