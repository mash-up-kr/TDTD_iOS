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
    case requestWriteComment(roomCode: String, data: [MultipartFormData])
    case requestBookmark(roomCode: String, delete: Bool)
    case requestRoomDetail(roomCode: String)
    case requestRemoveRoom(roomCode: String)
    case requestExitRoom(roomCode: String)
    case requestReport(commentId: Int)
    case requestRemoveCommentFromUser(commentId: Int)
    case requestRemoveCommentFromHost(commentId: Int)
    case requestModifyRoomTitle(roomCode: String, title: String)
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
        case let .requestWriteComment(roomCode, _):
            return "/api/v1/comments/\(roomCode)"
        case let .requestBookmark(roomCode, _):
            return "/api/v1/bookmarks/\(roomCode)"
        case let .requestRoomDetail(roomCode):
            return "/api/v1/rooms/\(roomCode)"
        case let .requestRemoveRoom(roomCode):
            return "/api/v1/host/rooms/\(roomCode)"
        case let .requestExitRoom(roomCode):
            return "/api/v1/users/\(roomCode)"
        case let .requestReport(commentId):
            return "/api/v1/reports/\(commentId)"
        case let .requestRemoveCommentFromUser(commentId):
            return "/api/v1/comments/\(commentId)"
        case let .requestRemoveCommentFromHost(commentId):
            return "/api/v1/host/comments/\(commentId)"
        case let .requestModifyRoomTitle(roomCode, _):
            return "/api/v1/host/rooms/\(roomCode)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestRooms:
            return .get
        case .requestJoinRoom,
             .requestMakeRoom:
            return .post
        case .requestWriteComment:
            return .post
        case let .requestBookmark(_, delete):
            return delete ? .delete : .post
        case .requestRoomDetail:
            return .get
        case .requestRemoveRoom:
            return .delete
        case .requestExitRoom:
            return .delete
        case .requestReport:
            return .post
        case .requestRemoveCommentFromUser:
            return .delete
        case .requestRemoveCommentFromHost:
            return .delete
        case .requestModifyRoomTitle:
            return .patch
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
            
        case let .requestWriteComment(_, data):
            return .uploadMultipart(data)
            
        case .requestBookmark:
            return .requestPlain
            
        case .requestRoomDetail:
            return .requestPlain
            
        case .requestRemoveRoom:
            return .requestPlain
            
        case .requestExitRoom:
            return .requestPlain
            
        case .requestReport:
            return .requestPlain
        
        case .requestRemoveCommentFromUser:
            return .requestPlain
            
        case .requestRemoveCommentFromHost:
            return .requestPlain

        case let .requestModifyRoomTitle(_, title):
            let parameters: [String: Any] = [
                "new_title": title
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
}
