//
//  HomeView.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/27.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        ScrollView {
            LazyVStack(spacing: 8) {
                CreatCardView()
                CardSectionTitleView()
                CardView()
                CardView()
                CardView()
                CardView()
                CardView()

            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
