//
//  TextFieldFormItem.swift
//  TDTD
//
//  Created by juhee on 2021/02/27.
//

import SwiftUI

struct TextFieldFormItem: View {
    
    @ObservedObject var viewModel: FocusTextFieldViewModel

    var body: some View {
        VStack {
            HStack {
                SubTitle(text: self.viewModel.title)
                Spacer()
                SubTitle(text: "\(self.viewModel.text.count)/\(self.viewModel.max)")
            }
            FocusTextFieldView(viewModel: self.viewModel)
        }
    }
}


struct TextFieldFormItem_Previews: PreviewProvider {

    static var previews: some View {
        TextFieldFormItem(viewModel: FocusTextFieldViewModel(title: "타이틀", text: "", placeholder: "타이틀을 작성하세요", max: 35))
    }

}
