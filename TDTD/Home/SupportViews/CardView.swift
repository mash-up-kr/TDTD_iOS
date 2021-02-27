//
//  CardView.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/27.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        
        VStack(spacing: 40) {
            HStack(spacing: 16) {
                Text("Hello")
                    .foregroundColor(.init("grayscale_1"))
                    .font(.uhBeeCustom(20, weight: .bold))
            }
            Text("Hello")
                .foregroundColor(.black)
        }
        
        .padding(16)
//        .foregroundColor(.init("beige_2"))
        .background(Color.init("beige_2"))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.init("beige_3"), lineWidth: 1)
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
