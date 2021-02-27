//
//  CreatCardView.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/27.
//

import SwiftUI

struct CreatCardView: View {
    var body: some View {
        ZStack {
            
            ZStack {
                VStack {
                    Spacer()
                    Image("ic_plus_40")
                    Spacer()
                }
                VStack {
                    Spacer()
                    Text("롤링페이퍼 만들기")
                        .font(.uhBeeCustom(16, weight: .bold))
                        .foregroundColor(.init("beige_6"))
                    Spacer()
                        .frame(height: 33)
                }
            }

            
            

            Image("")
            
        }
        .frame(width: 300, height: 160, alignment: .center)
        .background(Color.init("beige_2"))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.init("beige_3"), lineWidth: 1)
        )
    }
}

struct CreatCardView_Previews: PreviewProvider {
    static var previews: some View {
        CreatCardView().padding()
    }
}
