//
//  API.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/28.
//

import Foundation
import Moya

enum API {
    case requestJoinRoom(roomCode: String)
}

extension API: TargetType {
    var path: String {
        switch self {
        case let .requestJoinRoom(roomCode):
            return "api/v1/users/\(roomCode)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestJoinRoom:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .requestJoinRoom:
            return .requestPlain
        }
    }
    
}
