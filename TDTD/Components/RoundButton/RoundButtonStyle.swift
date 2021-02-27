//
//  RoundButtonStyle.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/27.
//

import SwiftUI

struct RoundButtonStyle: ButtonStyle {
    var style: Style
    var size: Size = .default
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(size.font)
            .foregroundColor(style.forgroundColor)
            .padding(.vertical, 12)
            .padding(.horizontal, 12)
            .background(style.backgroundColor)
            .cornerRadius(size.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: size.cornerRadius)
                    .strokeBorder(style.borderColor, lineWidth: 1)
            )
    }
}

extension RoundButtonStyle {
    enum Style {
        case light
        case dark
        
        var forgroundColor: Color {
            switch self {
            case .light:
                return .init("grayscale_1")
            case .dark:
                return .white
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .light:
                return .init("beige_1")
            case .dark:
                return .init("grayscale_1")
            }
        }
        
        var borderColor: Color {
            switch self {
            case .light:
                return .init("grayscale_3")
            case .dark:
                return .clear
            }
        }
    }
}

extension RoundButtonStyle {
    enum Size {
        case `default`
        case small
        
        var font: Font {
            switch self {
            case .default:
                return Font.uhBeeCustom(20, weight: .bold)
            case .small:
                return Font.uhBeeCustom(16, weight: .bold)
            }
        }
        
        var cornerRadius: CGFloat {
            switch self {
            case .default:
                return 12
            case .small:
                return 12
            }
        }
    }
}

struct RoundButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("방 나가기", action: {})
                .buttonStyle(RoundButtonStyle(style: .light))
            Button("취소", action: {})
                .buttonStyle(RoundButtonStyle(style: .dark, size: .small))
        }
    }
}
