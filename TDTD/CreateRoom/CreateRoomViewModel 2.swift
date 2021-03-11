//
//  CreateRoomViewModel.swift
//  TDTD
//
//  Created by juhee on 2021/02/27.
//

import Foundation
import SwiftUI


class CreateRoomViewModel: ObservableObject {
    
    @Published var type: RoomType = .none {
        didSet {
            print("[caution] new type \(type.title)")
        }
    }
    @Published var title: String = "" {
        didSet {
            print("[caution] new title \(title)")
        }
    }
    
    
    func updateRoom(type: RoomType) {
        self.type = type
    }
    
    func isRoom(type: RoomType) -> Bool {
        return self.type == type
    }
    
    func createRoom() {
        //TODO:- Create Room
    }
    
}
