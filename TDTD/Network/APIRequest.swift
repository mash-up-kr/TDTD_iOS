//
//  APIRequest.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/28.
//

import Foundation
import Moya

final class APIRequest {
    
    private init() { }
    
    private let provider = MoyaProvider<API>.init(session: DefaultAlamofireSession.sharedSession)
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
    
}

