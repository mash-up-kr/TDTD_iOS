//
//  CreateRoomViewModel.swift
//  TDTD
//
//  Created by juhee on 2021/02/27.
//

import Foundation
import SwiftUI


class CreateRoomViewModel: ObservableObject {
    
    @Published private(set) var room: Room = Room()
    
    
    func updateRoom(type: RoomType) {
        self.room.type = type
    }
    
    func isRoom(type: RoomType) -> Bool {
        return self.room.type == type
    }
    
    func createRoom() {
        //TODO:- Create Room
    }
    
}
