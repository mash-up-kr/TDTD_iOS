//
//  RoundButton.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/27.
//

import SwiftUI

struct RoundButton: ButtonStyle {
    var style: Style
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(style.forgroundColor)
            .padding()
            .background(style.backgroundColor)
            .cornerRadius(12)
//            .border(style.borderColor, width: 1, cornerRadius: 20)
//            .overlay(
//                RoundedRectangle
//            )
    }
}

extension RoundButton {
    enum Style {
        case light
        case dark
        
        var forgroundColor: Color {
            switch self {
            case .light:
                return .black
            case .dark:
                return .white
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .light:
                return .yellow
            case .dark:
                return .blue
            }
        }
        
        var borderColor: Color {
            switch self {
            case .light:
                return Color(red: 0.533, green: 0.514, blue: 0.565)
            case .dark:
                return .clear
            }
        }
        
        
    }
}

struct RoundButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("Title", action: {})
                .buttonStyle(RoundButton(style: .light))
            Button("Title", action: {})
                .buttonStyle(RoundButton(style: .dark))
        }

    }
}
