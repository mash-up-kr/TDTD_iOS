//
//  HomeView.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/27.
//

import SwiftUI
import FirebaseAnalytics

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var presentCreatRoom = false
    @State private var showFavoritesOnly = false
    @State private var isDeepLinkRefresh = false
    @State private var isPresentCreateAfterDirectView = false
    private var rooms: [RoomSummary] {
        viewModel.rooms.filter { roomSummary in
            (!showFavoritesOnly || roomSummary.isBookmark)
        }.sorted { $0.createdAt ?? "" > $1.createdAt ?? "" }
    }
    
    init(viewModel: HomeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
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
                                let view = RollingpaperView(viewModel: RollingpaperViewModel(roomInfo: roomSummary), isDeepLinkRefresh: $isDeepLinkRefresh)
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
                Analytics.logEvent(AnalyticsScreenName.home,
                                   parameters: nil)
            }
            .onReceive(viewModel.$isPopToRoot) {
                if $0 {
                    isDeepLinkRefresh = true
                }
            }
        }
        .sheet(isPresented: $presentCreatRoom, content: {
            let viewModel = CreateRoomViewModel()
            CreateRoomView(viewModel: viewModel,
                           presentCreatRoom: $presentCreatRoom, isPresentCreateAfterDirectView: $isPresentCreateAfterDirectView)
                .environmentObject(self.viewModel)
        })
        .alert(isPresented: $viewModel.isNotExistRoom) {
            Alert(title: Text("이미 삭제된 방이에요😭"),
                  message: Text("링크를 다시 한번 확인해주세요"))
        }
        
    }
    
    @ViewBuilder
    private func moveNewRoom() -> some View {
        if let roomCode = viewModel.roomCode,
           let roomType = viewModel.roomType {
            let newViewModel = RollingpaperViewModel(roomCode: roomCode, roomType: roomType)
            let newRollingPaperView = RollingpaperView(viewModel: newViewModel,
                                                       isDeepLinkRefresh: $isDeepLinkRefresh)
                .onDisappear {
                    viewModel.roomCode = nil
                    viewModel.roomType = nil
                    isPresentCreateAfterDirectView = false
                }
            NavigationLink(destination: newRollingPaperView, isActive: $isPresentCreateAfterDirectView) {
                EmptyView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
