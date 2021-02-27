//
//  FocusTextFieldView.swift
//  TDTD
//
//  Created by 남수김 on 2021/02/27.
//

import SwiftUI

struct FocusTextFieldView: View {
    private let radius: CGFloat = 16
    private let horizontalPadding: CGFloat = 16
    private let verticalPadding: CGFloat = 12
    
    @Binding var text: String
    @EnvironmentObject var viewmodel: RollingpaperWriteViewModel
    
    var body: some View {
        ZStack {
            if viewmodel.isEditing {
                ZStack {
                    RoundedRectangle(cornerRadius: radius)
                        .fill(Color(UIColor(named: "beige_2")!))
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color(UIColor(named: "grayscale_2")!), lineWidth: 2)
                }
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: radius)
                        .fill(Color(UIColor(named: "beige_2")!))
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color(UIColor(named: "beige_3")!), lineWidth: 1)
                }
            }
            
            TextField("", text: $text) { isEditing in
                viewmodel.isEditing = isEditing
            }
            .disableAutocorrection(true)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
        }.frame(maxHeight: 48)
    }
}
