//
//  ContentView.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("hello\(Date().fileFormat)")
            .font(Font.custom("UhBee ZIGLE", size: 16))
            .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
