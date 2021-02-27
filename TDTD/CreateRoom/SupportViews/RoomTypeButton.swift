//
//  RoomTypeButton.swift
//  TDTD
//
//  Created by juhee on 2021/02/27.
//

import SwiftUI

struct RoomTypeButton: View {
    
    let type: RoomType
    @Binding var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            self.isSelected = true
            action()
        }, label: {
            ZStack(alignment: .bottom) {
                FocusView(isFocused: self.$isSelected)
                VStack {
                    Text(type.title)
                        .font(.uhBeeCustom(20))
                        .foregroundColor(Color("grayscale_1"))
                        .frame(height: 20, alignment: .bottom)
                    Text(type.description)
                        .font(.uhBeeCustom(16))
                        .foregroundColor(Color("grayscale_2"))
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                    Image(type.image)
                        .frame(height: 80, alignment: .bottom)
                }
                .padding(.top, 16.0)
                .frame(minWidth: 152, maxHeight: .infinity)
            }
        }).frame(height: 168, alignment: .center)
    }
    
}

struct RoomTypeButton_Previews: PreviewProvider {
    static var previews: some View {
        RoomTypeButton(type: .voice, isSelected: .constant(true)) {
            
        }
    }
}
