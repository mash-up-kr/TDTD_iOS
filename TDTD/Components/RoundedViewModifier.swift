//
//  RoundedViewModifier.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/08.
//

import SwiftUI


struct RoundedRectangleCustomShape: Shape {
    let radius: CGFloat
    let cornerStyle: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                     byRoundingCorners: cornerStyle,
                     cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct RoundedViewModifier: ViewModifier {
    let radius: CGFloat
    let cornerStyle: UIRectCorner
    
    func body(content: Content) -> some View {
        content.clipShape(RoundedRectangleCustomShape(radius: radius, cornerStyle: cornerStyle))
    }
}

extension View {
    func cornerRadius(radius: CGFloat, cornerStyle corner: UIRectCorner) -> some View {
        self.modifier(RoundedViewModifier(radius: radius, cornerStyle: corner))
    }
}
