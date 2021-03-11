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
    case requestWriteComment(roomCode: String, data: [MultipartFormData])
}

extension API: TargetType {
    var path: String {
        switch self {
        case .requestRooms:
            return "api/v1/rooms"
        case let .requestJoinRoom(roomCode):
            return "api/v1/users/\(roomCode)"
        case let .requestWriteComment(roomCode, _):
            return "api/v1/comments/\(roomCode)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestRooms:
            return .get
        case .requestJoinRoom:
            return .post
        case .requestWriteComment:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .requestRooms:
            return .requestPlain
        case .requestJoinRoom:
            return .requestPlain
        case let .requestWriteComment(_, data):
            return .uploadMultipart(data)
        }
    }
}
