//
//  HomeViewModel.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/28.
//

import SwiftUI
import Combine
import AppTrackingTransparency

final class HomeViewModel: ObservableObject {
    @Published var rooms = [RoomSummary]()
    @Published var isPopToRoot: Bool = false
    @Published var isNotExistRoom = false
    // 만들고 바로 입장시 필요한 변수들
    var roomCode: String?
    var roomType: RoomType?
    
    private var bag = Set<AnyCancellable>()
}

extension HomeViewModel {
    func requestRooms() {
        APIRequest.shared.requestRooms()
            .sink(receiveCompletion: { _ in }
            , receiveValue: {
                if let rooms = try? $0.map(ResponseModel<[RoomSummary]>.self) {
                    self.rooms = rooms.result
                }
            })
            .store(in: &bag)
    }
    
    func popToRoot() {
        isPopToRoot = true
    }
}
