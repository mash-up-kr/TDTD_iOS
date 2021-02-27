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
    
    @State private var text: String
    @State private var isEditing: Bool = false
    
    init(_ text: String) {
        _text = State(wrappedValue: text)
        
    }
    
    var body: some View {
        ZStack {
            if isEditing {
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
                self.isEditing = isEditing
            }
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
        }.frame(maxHeight: 48)
    }
}
