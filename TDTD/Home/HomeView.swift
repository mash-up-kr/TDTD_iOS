//
//  HomeView.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/27.
//

import SwiftUI

struct HomeView: View {
    @State private var presentCreatRoom = false
    
    init() {
        setNavigationBar()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(Color("beige_1"))
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                        .frame(maxHeight: 16)
                    ScrollView {
                        VStack(spacing: 8) {
                            CreatCardView(action: {
                                presentCreatRoom = true
                            })
                            Spacer().frame(height: 16)
                            CardSectionTitleView()
                        }
                        .padding(.horizontal, 16)
                        LazyVStack(spacing: 8) {
                            CardView()
                            CardView()
                            CardView()
                            CardView()
                            CardView()
                            CardView()
                            CardView()
                            CardView()
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: Image("logo"),
                                trailing: Image("ic_settingButton_40")
            )
        }
        .sheet(isPresented: $presentCreatRoom, content: {
            CreateRoomView(viewModel: CreateRoomViewModel())
        })
    }
}

extension HomeView {
    private func setNavigationBar() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = .clear
        UINavigationBar.appearance().backgroundColor = .init(Color("beige_1"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
