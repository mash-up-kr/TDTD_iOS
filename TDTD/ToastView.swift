//
//  ToastView.swift
//  TDTD
//
//  Created by juhee on 2021/02/27.
//

import SwiftUI

struct ToastView<Presenting>: View where Presenting: View {
    
    @Binding var isShowing: Bool
    
    let presenting: () -> Presenting
    let hideAfter: TimeInterval
    var title: Text
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                self.presenting()
                
                if self.isShowing {
                    VStack {
                        self.title
                            .foregroundColor(.white)
                            .font(Font.custom("UhBee ZIGLE Bold", size: 16))
                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .background(RoundedRectangle(cornerRadius: 24.5, style: .continuous)
                                            .foregroundColor(Color("character_1")))
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6)
                    }
                    .transition(.slide)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + self.hideAfter) {
                            withAnimation {
                                self.isShowing = false
                            }
                        }
                    }
                }
            }
        }
    }
    
    
}


extension View {

    func toast(isShowing: Binding<Bool>, title: Text, hideAfter: TimeInterval) -> some View {
        ToastView(isShowing: isShowing, presenting: { self }, hideAfter: hideAfter, title: title)
    }

}
