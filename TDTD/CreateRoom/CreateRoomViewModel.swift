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
    
    var isRoomCreated: ((String) -> Void)?
    
    private var bag = Set<AnyCancellable>()
    
    init(isPresented: Binding<Bool>, isRoomCreated: ((String) -> Void)? = nil) {
        self._isPresented = isPresented
        self.isRoomCreated = isRoomCreated
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
                  , receiveValue: { [weak self] in
                    if let roomCode = try? $0.map(String.self, atKeyPath: "room_code") {
                        self?.isPresented = false
                        self?.isRoomCreated?(roomCode)
                    }
                  })
            .store(in: &bag)
    }
}
