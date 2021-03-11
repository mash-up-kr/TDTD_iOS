//
//  ColorPallete.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/11.
//

import SwiftUI

enum ColorPallete {
    case grayscale(_ : Int)
    case beige(_ : Int)
    case point
    
    var color: Color {
        switch self {
        case .grayscale(let n):
            return Color("grayscale_\(n)")
        case .beige(let n):
            return Color("beige_\(n)")
        case .point:
            return Color("point")
        }
    }
}
