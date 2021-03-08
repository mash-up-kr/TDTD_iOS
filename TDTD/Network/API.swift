//
//  API.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/28.
//

import Foundation
import Moya

enum API {
    case requestRooms
    case requestJoinRoom(roomCode: String)
}

extension API: TargetType {
    var path: String {
        switch self {
        case .requestRooms:
            return "api/v1/rooms"
        case let .requestJoinRoom(roomCode):
            return "api/v1/users/\(roomCode)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestRooms:
            return .get
        case .requestJoinRoom:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .requestRooms:
            return .requestPlain
        case .requestJoinRoom:
            return .requestPlain
        }
    }
    
}
