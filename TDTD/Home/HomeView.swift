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
        Array(Set(viewModel.rooms.filter { roomSummary in
            (!showFavoritesOnly || roomSummary.isBookmark)
        })).sorted { $0.createdAt ?? "" > $1.createdAt ?? "" }
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
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
                                let view = RollingpaperView(viewModel: RollingpaperViewModel(roomCode: roomSummary.roomCode ?? "", mode: .text))
                                NavigationLink(destination: view) {
                                    CardView(roomSummary: roomSummary)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
