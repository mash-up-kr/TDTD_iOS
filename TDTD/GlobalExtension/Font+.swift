//
//  Font+.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/27.
//

import SwiftUI

extension Font {
    enum CustomFontWeight {
        case regular
        case bold
        
        var name: String {
            switch self {
            case .regular:
                return "UhBee ZIGLE Bold"
            case .bold:
                return "UhBee ZIGLE"
            }
        }
    }
    
    static func uhBeeCustom(_ fixedSize: CGFloat, weight: CustomFontWeight = .regular) -> Font {
        return Font.custom(weight.name, fixedSize: fixedSize)
    }
}
