//
//  CreatCardView.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/27.
//

import SwiftUI

struct CreatCardView: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            ZStack {
                ZStack {
                    VStack {
                        Spacer()
                        Image("ic_plus_40")
                        Spacer()
                            .frame(height: 10)
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
                Image("img_create_room")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            }
            .frame(height: 160, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.init("beige_2"))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color.init("beige_3"), lineWidth: 1)
            )
        })
    }
}

struct CreatCardView_Previews: PreviewProvider {
    static var previews: some View {
        CreatCardView(action: {}).padding(12)
    }
}
