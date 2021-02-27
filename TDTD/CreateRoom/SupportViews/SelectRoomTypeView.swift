//
//  SelectRoomTypeView.swift
//  TDTD
//
//  Created by juhee on 2021/02/28.
//

import SwiftUI

struct SelectRoomTypeView: View {
    
    @Binding var selectedType: RoomType
    
    var body: some View {
        VStack(alignment: .leading) {
            SubTitle(text: "롤링페이퍼 작성 방법")
            HStack {
                RoomTypeButton(type: .voice, isSelected: Binding<Bool>(
                    get: {
                        self.selectedType == .voice
                    }, set: { isSelected in
                        if isSelected {
                            self.selectedType = .voice
                        }
                    }
                )) {
                    self.selectedType = .voice
                }
                RoomTypeButton(type: .text, isSelected: Binding<Bool>(
                    get: {
                        self.selectedType == .text
                    }, set: { isSelected in
                        if isSelected {
                            self.selectedType = .text
                        }
                    }
                )) {
                    self.selectedType = .text
                }
            }
        }
    }
}

struct SelectRoomTypeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectRoomTypeView(selectedType: .constant(.voice))
    }
}
