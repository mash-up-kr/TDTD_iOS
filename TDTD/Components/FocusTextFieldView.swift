//
//  FocusTextFieldView.swift
//  TDTD
//
//  Created by 남수김 on 2021/02/27.
//

import SwiftUI

struct FocusTextFieldView: View {
    @Binding var text: String
    @State private var isFocused: Bool = false
    @Binding var isWrite: Bool
    let title: String
    let max: Int
    let placeholder: String
    
    private let radius: CGFloat = 16
    private let horizontalPadding: CGFloat = 16
    private let verticalPadding: CGFloat = 12
    
    var body: some View {
        ZStack {
            FocusView(isFocused: $isFocused)
            TextField(self.placeholder, text: self.$text
                      , onEditingChanged: { isEditing in
                        self.isFocused = isEditing
                        self.isWrite = isEditing
            })
                .padding(.vertical, verticalPadding)
                .padding(.horizontal, horizontalPadding)
                .font(.uhBeeCustom(20, weight: .bold))
                .foregroundColor(Color("grayscale_1"))
        }.frame(maxHeight: 48)
    }

}
