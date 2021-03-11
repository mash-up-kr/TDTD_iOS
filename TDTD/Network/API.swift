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
    case requestMakeRoom(title: String, type: RoomType)
}

extension API: TargetType {
    var path: String {
        switch self {
        case .requestRooms:
            return "api/v1/rooms"
        case let .requestJoinRoom(roomCode):
            return "api/v1/users/\(roomCode)"
        case .requestMakeRoom:
            return "/api/v1/rooms"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestRooms:
            return .get
            
        case .requestJoinRoom,
             .requestMakeRoom:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .requestRooms:
            return .requestPlain
            
        case .requestJoinRoom:
            return .requestPlain
            
        case let .requestMakeRoom(title, type):
            let parameters: [String: Any] = [
                "title": title,
                "type": type.rawValue
            ]
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
}
