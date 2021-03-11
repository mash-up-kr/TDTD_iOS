//
//  HomeView.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/27.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    @State private var presentCreatRoom = false
    @State private var showFavoritesOnly = false
    
    private var rooms: [RoomSummary] {
        viewModel.rooms.filter { roomSummary in
            (!showFavoritesOnly || roomSummary.isBookmark)
        }
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
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
                            CardSectionTitleView(isFavorite: $showFavoritesOnly)
                        }
                        .padding(.horizontal, 16)
                        LazyVStack(spacing: 8) {
                            ForEach(rooms, id: \.self.roomCode) { roomSummary in
//                                NavigationLink(destination: RollingpaperView(viewModel: RollingpaperViewModel.init(mode: .text))) {
                                    CardView(roomSummary: roomSummary)
//                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: Image("logo"),
                                trailing: Image("ic_settingButton_40")
            )
            .onAppear {
                viewModel.requestRooms()
            }
        }
        .sheet(isPresented: $presentCreatRoom, content: {
            let viewModel = CreateRoomViewModel(isPresented: $presentCreatRoom) {
                self.viewModel.roomCode = $0
            }
            CreateRoomView(viewModel: viewModel)
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
        HomeView(viewModel: HomeViewModel())
    }
}
