//
//  CreateRoomViewModel.swift
//  TDTD
//
//  Created by juhee on 2021/02/27.
//

import Foundation
import SwiftUI
import Combine


class CreateRoomViewModel: ObservableObject {
    
    @Published private(set) var room: Room = Room()
    @Binding var isPresented: Bool
    @Published var roomCode: String?
    
    private var bag = Set<AnyCancellable>()
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    
    func updateRoom(type: RoomType) {
        self.room.type = type
    }
    
    func isRoom(type: RoomType) -> Bool {
        return self.room.type == type
    }
    
    func createRoom() {
        //TODO:- Create Room
        requestMakeRoom()
    }
    
    
    
}


extension CreateRoomViewModel {
    private func requestMakeRoom() {
        APIRequest.shared.requestMakeRoom(title: "testRoom", type: room.type)
            .sink(receiveCompletion: { _ in }
                  , receiveValue: {
                    if let roomCode = try? $0.map(String.self) {
                        self.isPresented = false
                        self.roomCode = roomCode
                    }
                  })
            .store(in: &bag)
    }
}
