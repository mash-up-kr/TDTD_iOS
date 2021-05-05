//
//  HomeViewModel.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/28.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {
    @Published var rooms = [RoomSummary]()
    @Published var isPopToRoot: Bool = false
    var roomCode: String?
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
