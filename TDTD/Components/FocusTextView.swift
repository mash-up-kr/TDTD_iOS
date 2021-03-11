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
    let placeholder: String
    var onEditing: ((Bool) -> Void)?
    
    var body: some View {
        UITextViewWrapper(text: $text, onEditing: onEditing)
            .frame(height: 184)
            .overlay(
                ZStack {
                    if text.isEmpty {
                        PlaceholderView(text: placeholder)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                    }
                }
                ,
                alignment: .topLeading)
    }
}

struct FocusTextView_Previews: PreviewProvider {
    static var previews: some View {
        FocusTextView(text: Binding.constant(""), placeholder: "남기고 싶은 말을 써주세요!")
    }
}

struct UITextViewWrapper: UIViewRepresentable {
    private let radius: CGFloat = 16
    @Binding var text: String
    var onEditing: ((Bool) -> Void)?
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = Font.uhBeeCustom(20, weight: .bold)
        textView.delegate = context.coordinator
        textView.backgroundColor = UIColor(named: "beige_2")
        textView.layer.cornerRadius = radius
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(named: "beige_3")?.cgColor
        textView.autocorrectionType = .no
        textView.contentInset = .init(top: 12, left: 16, bottom: 12, right: 16)
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
            parent.onEditing?(true)
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.layer.borderWidth = 2
            textView.layer.borderColor = UIColor(named: "grayscale_2")?.cgColor
            parent.onEditing?(true)
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            textView.layer.borderWidth = 1
            textView.layer.borderColor = UIColor(named: "beige_3")?.cgColor
            parent.onEditing?(false)
        }
    }
}
