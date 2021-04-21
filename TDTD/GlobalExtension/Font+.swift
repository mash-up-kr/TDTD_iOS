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
                return "UhBee ZIGLE"
            case .bold:    
                return "UhBee ZIGLE Bold"
            }
        }
    }
    
    static func uhBeeCustom(_ fixedSize: CGFloat, weight: CustomFontWeight = .regular) -> Font {
        return Font.custom(weight.name, fixedSize: fixedSize)
    }
}

extension UIFont {
    enum CustomFontWeight {
        case regular
        case bold
        
        var name: String {
            switch self {
            case .regular:
                return "UhBee ZIGLE"
            case .bold:
                return "UhBee ZIGLE Bold"
            }
        }
    }
    
    static func uhBeeCustom(_ fixedSize: CGFloat, weight: CustomFontWeight = .regular) -> UIFont {
        return UIFont(name: weight.name, size: fixedSize) ?? UIFont.systemFont(ofSize: fixedSize)
    }
}
