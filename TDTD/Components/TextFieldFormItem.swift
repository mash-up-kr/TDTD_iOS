//
//  TextFieldFormItem.swift
//  TDTD
//
//  Created by juhee on 2021/02/27.
//

import SwiftUI

struct TextFieldFormItem: View {
    @Binding var text: String
    @State var textCount: Int = 0
    let title: String
    let max: Int
    let placeholder: String

    var body: some View {
        VStack {
            HStack {
                SubTitle(text: self.title)
                Spacer()
                ChangeableSubTitle(text: Binding(get: {
                    "\(self.textCount)/ \(self.max)"
                }, set: { _ in
                }))
            }
            FocusTextFieldView(text: self.$text, title: title, max: max, placeholder: placeholder)
        }.onChange(of: self.text, perform: { value in
            self.textCount = value.count
            if value.count > self.max {
                let maxIndex = value.index(self.text.startIndex, offsetBy: max)
                self.text = String(value[..<maxIndex])
            }
        })
    }
    
    func convertToCount() -> Int {
        return self.text.count
    }
}


//struct TextFieldFormItem_Previews: PreviewProvider {
//
//    static var previews: some View {
//        TextFieldFormItem(title: "타이틀", text: "", placeholder: "타이틀을 작성하세요", max: 35)
//    }
//
//}
