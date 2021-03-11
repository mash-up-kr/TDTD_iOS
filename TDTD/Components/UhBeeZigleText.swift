//
//  UhBeeZigleText.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/11.
//

import SwiftUI

struct UhBeeZigleText: View {
    let text: String
    let size: CGFloat
    let weight: Font.CustomFontWeight
    let pallete: ColorPallete
    
    init(_ text: String, size: CGFloat = 20, weight: Font.CustomFontWeight = .regular, pallete: ColorPallete) {
        self.text = text
        self.size = size
        self.weight = weight
        self.pallete = pallete
    }
    
    var body: some View {
        Text(text)
            .font(Font.uhBeeCustom(size, weight: weight))
            .foregroundColor(pallete.color)
    }
}
