//
//  APIRequest.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/28.
//

import Foundation
import Moya
import Combine

final class APIRequest {
    
    private init() { }
    
    static let shared = APIRequest()
    
    private let provider = MoyaProvider<API>.init(session: DefaultAlamofireSession.sharedSession)
    
    private func request(_ api: API) -> Future<Response, Error> {
        Future<Response, Error> { [weak self] promise in
            guard let self = self else { return }
            self.provider.request(api) { result in
                switch result {
                case let .success(response):
                    promise(.success(response))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }
}

final class DefaultAlamofireSession: Session {
    static let sharedSession: DefaultAlamofireSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Session.default.session.configuration.httpAdditionalHeaders
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 50
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireSession(configuration: configuration)
    }()
}

extension APIRequest {
    func requestRooms() -> Future<Response, Error> {
        request(.requestRooms)
    }
    
    func requestMakeRoom(title: String, type: RoomType) -> Future<Response, Error> {
        request(.requestMakeRoom(title: title, type: type))
    }
    
    func requestWriteComment(roomCode: String, data: [MultipartFormData]) -> Future<Response, Error> {
        request(.requestWriteComment(roomCode: roomCode, data: data))
    }
    
    func requestBookmark(roomCode: String, delete: Bool) -> Future<Response, Error> {
        request(.requestBookmark(roomCode: roomCode, delete: delete))
    }
    
    func requestRoomDetail(roomCode: String) -> Future<Response, Error> {
        request(.requestRoomDetail(roomCode: roomCode))
    }
    
    func requestRemoveRoom(roomCode: String) -> Future<Response, Error> {
        request(.requestRemoveRoom(roomCode: roomCode))
    }
    
    func requestExitRoom(roomCode: String) -> Future<Response, Error> {
        request(.requestExitRoom(roomCode: roomCode))
    }
}

