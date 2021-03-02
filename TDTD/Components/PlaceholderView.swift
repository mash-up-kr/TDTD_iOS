//
//  PlaceholderView.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/02.
//

import SwiftUI

struct PlaceholderView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(Font.uhBeeCustom(20, weight: .bold))
            .foregroundColor(Color("grayscale_4"))
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView(text: "hihi")
    }
}
