//
//  FocusTextFieldViewModel.swift
//  TDTD
//
//  Created by juhee on 2021/02/27.
//

import SwiftUI


class FocusTextFieldViewModel: ObservableObject, TextFieldViewModel {
    
    init(title: String, text: String, placeholder: String, max: Int) {
        self.title = title
        self.text = text
        self.max = max
        self.placeholder = placeholder
    }
    
    //FIXME :- 방법 선택 시 초기화 되는 이슈 수정
    @State var text: String
    let title: String
    let max: Int
    let placeholder: String
    
}


protocol TextFieldViewModel: ObservableObject {

    var title: String { get }
    var text: String { get set }
    var max: Int { get }
    var placeholder: String { get }

}
