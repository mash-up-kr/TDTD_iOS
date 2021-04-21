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
    @State private var isCanMakeRoomFirstEnter = true
    
    private var rooms: [RoomSummary] {
        Array(viewModel.rooms.filter { roomSummary in
            (!showFavoritesOnly || roomSummary.isBookmark)
        }).sorted { $0.createdAt ?? "" > $1.createdAt ?? "" }
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                moveNewRoom()
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
                            ForEach(rooms, id: \.roomCode) { roomSummary in
                                let view = RollingpaperView(viewModel: RollingpaperViewModel(roomInfo: roomSummary))
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
            .navigationBarItems(leading: Image("logo"))
// TODO: 추후 설정창 옵션추가시 구현
//            trailing: Image("ic_settingButton_40")
            .onAppear {
                viewModel.requestRooms()
            }
        }
        .sheet(isPresented: $presentCreatRoom, content: {
            let viewModel = CreateRoomViewModel()
            CreateRoomView(viewModel: viewModel,
                           presentCreatRoom: $presentCreatRoom)
                .environmentObject(self.viewModel)
        })
        
    }
    
    @ViewBuilder
    private func moveNewRoom() -> some View {
        if let roomCode = viewModel.roomCode {
            let newViewModel = RollingpaperViewModel(roomCode: roomCode)
            let newRollingPaperView = RollingpaperView(viewModel: newViewModel)
            NavigationLink(destination: newRollingPaperView, isActive: .constant(true)) {
                EmptyView()
            }
            .onDisappear {
                viewModel.roomCode = nil
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
