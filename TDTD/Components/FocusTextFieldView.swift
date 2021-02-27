//
//  FocusTextFieldView.swift
//  TDTD
//
//  Created by 남수김 on 2021/02/27.
//

import SwiftUI

struct FocusTextFieldView: View {
    
    @ObservedObject var viewModel: FocusTextFieldViewModel
    
    private let radius: CGFloat = 16
    private let horizontalPadding: CGFloat = 16
    private let verticalPadding: CGFloat = 12
    
    @State var isFocused: Bool = false
    
    init(viewModel: FocusTextFieldViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            FocusView(isFocused: self.$isFocused)
            TextField(self.viewModel.placeholder, text: Binding<String>(
                get: { self.viewModel.text },
                set: {
                    self.viewModel.text = $0
                }
            ), onEditingChanged: { isEditing in
                self.isFocused = isEditing
            })
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .font(.uhBeeCustom(20))
            .foregroundColor(Color("grayscale_1"))
        }.frame(maxHeight: 48)
    }

}
