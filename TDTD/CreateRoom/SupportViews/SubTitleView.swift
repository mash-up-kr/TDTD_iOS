//
//  SubTitle.swift
//  TDTD
//
//  Created by juhee on 2021/02/27.
//

import SwiftUI


struct ChangeableSubTitle: View {
    
    @Binding var text: String

    var body: some View {
        Text(self.text)
            .font(.uhBeeCustom(20, weight: .bold))
            .foregroundColor(Color("grayscale_1"))
    }

}


struct SubTitle: View {
    
    @State var text: String

    var body: some View {
        Text(self.text)
            .font(.uhBeeCustom(20, weight: .bold))
            .foregroundColor(Color("grayscale_1"))
    }
}

struct SubTitle_Previews: PreviewProvider {
    static var previews: some View {
        SubTitle(text: "Hello")
    }
}
