//
//  FocusTextView.swift
//  TDTD
//
//  Created by 남수김 on 2021/02/27.
//

import SwiftUI

struct FocusTextView: View {
    private let radius: CGFloat = 16
    private let horizontalPadding: CGFloat = 16
    private let verticalPadding: CGFloat = 12
    @Binding var text: String
    @Binding var isWrite: Bool
    @State private var isFocused: Bool = false
    let placeholder: String
    
    var body: some View {
        ZStack {
            FocusView(isFocused: $isFocused)
            UITextViewWrapper(text: $text, isWrite: $isWrite, isFocused: $isFocused, placeholder: placeholder)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
        }
    }
}

struct FocusTextView_Previews: PreviewProvider {
    static var previews: some View {
        FocusTextView(text: Binding.constant(""), isWrite: Binding.constant(true), placeholder: "남기고 싶은 말을 써주세요!")
    }
}

struct UITextViewWrapper: UIViewRepresentable {
    private let radius: CGFloat = 16
    @Binding var text: String
    @Binding var isWrite: Bool
    @Binding var isFocused: Bool
    let placeholder: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.text = placeholder
        textView.textColor = UIColor(named: "grayscale_4")
        textView.font = Font.uhBeeCustom(20, weight: .bold)
        textView.delegate = context.coordinator
        textView.backgroundColor = .clear
        textView.autocorrectionType = .no
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
     
    }
    
    class Coordinator : NSObject, UITextViewDelegate {
        var parent: UITextViewWrapper
        
        init(_ uiTextView: UITextViewWrapper) {
            self.parent = uiTextView
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.placeholder {
                textView.text = ""
                textView.textColor = UIColor(named: "grayscale_1")
            }
            parent.isWrite = true
            parent.isFocused = true
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.textColor = UIColor(named: "grayscale_4")
                textView.text = parent.placeholder
            }
            parent.isWrite = false
            parent.isFocused = false
        }
    }
}
