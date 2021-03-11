//
//  HomeViewModel.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/28.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {
    @Published var rooms = [
        RoomSummary.init(isHost: true, title: "첫번째 타이틀입ㄴ다아아.", roomCode: "1", isBookmark: false, createdAt: nil),
        RoomSummary.init(isHost: true, title: "배포 가즈아아아아아아아아ㅏ아아ㅏ아아아아아", roomCode: "2", isBookmark: true, createdAt: nil),
        RoomSummary.init(isHost: true, title: "두줄이야야야암", roomCode: "3", isBookmark: false, createdAt: nil),
        RoomSummary.init(isHost: true, title: "첫번째 타이틀입ㄴ다아아.", roomCode: "4", isBookmark: false, createdAt: nil),
        RoomSummary.init(isHost: true, title: "한문장 아무말 이것도 아무말", roomCode: "5", isBookmark: false, createdAt: nil),
        RoomSummary.init(isHost: true, title: "목 데이터 필요한데 귀찮드아!!!!!", roomCode: "6", isBookmark: false, createdAt: nil),
        RoomSummary.init(isHost: true, title: "아무나 드루와", roomCode: "7", isBookmark: true, createdAt: nil)
    ]
    
    @Published var roomCode: String? = ""
    private var bag = Set<AnyCancellable>()
}

extension HomeViewModel {
    func requestRooms() {
        APIRequest.shared.requestRooms()
            .sink(receiveCompletion: { _ in }
            , receiveValue: {
                if let rooms = try? $0.map([RoomSummary].self) {
                    self.rooms = rooms
                }
            })
            .store(in: &bag)
    }
}
