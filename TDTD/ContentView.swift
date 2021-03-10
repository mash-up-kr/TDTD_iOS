//
//  ContentView.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/19.
//

import SwiftUI

struct ContentView: View {
    
//    @State private var showingCreateRoom = false
    
    var body: some View {
        Text("hello\(Date().fileFormat)")
            .font(Font.custom("UhBee ZIGLE", size: 16))
            .padding()
//        Button(action: {
//            self.showingCreateRoom.toggle()
//        }, label: {
//            Text("방만들기")
//        })
//        .sheet(isPresented: $showingCreateRoom, content: {
//            CreateRoomView(viewModel: CreateRoomViewModel())
//        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
