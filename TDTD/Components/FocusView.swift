//
//  FocusView.swift
//  TDTD
//
//  Created by juhee on 2021/02/27.
//

import SwiftUI

struct FocusView: View {
    
    @Binding var isFocused: Bool
    private let radius: CGFloat = 16
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: radius)
                .fill(Color("beige_2"))
            RoundedRectangle(cornerRadius: radius)
                .stroke(strokeColor, lineWidth: lineWidth)
        }
    }
    
    var strokeColor: Color {
        isFocused ? Color("grayscale_2") : Color("beige_3")
    }
    
    var lineWidth: CGFloat {
        isFocused ? 2 : 1
    }
    
}

struct FocusView_Previews: PreviewProvider {
    
    @State static var isFocused = true
    static var previews: some View {
        FocusView(isFocused: $isFocused)
    }
}
