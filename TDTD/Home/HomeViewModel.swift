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
