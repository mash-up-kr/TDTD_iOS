//
//  NavigationItemView.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/09.
//

import SwiftUI

struct NavigationItemView: View {
    let name: String
    let radius: CGFloat = 13
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: radius)
                .fill(Color("beige_3"))
            RoundedRectangle(cornerRadius: radius)
                .stroke(Color("beige_4"), lineWidth: 1)
            Image(name)
        }
        .frame(width: 40, height: 40)
    }
}

struct NavigationItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationItemView(name: "ic_arrow_left_24")
    }
}
