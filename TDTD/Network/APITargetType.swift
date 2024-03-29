//
//  APITargetType.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/28.
//

import Foundation
import Moya

extension TargetType {
    var baseURL: URL {
        #if DEBUG
        guard let url = URL(string: "http://dev.sokdak.shop") else { fatalError("Wrong URL") }
        #else
        guard let url = URL(string: "https://sokdak.shop") else { fatalError("Wrong URL") }
        #endif
        return url
    }
    
    var headers: [String: String]? {
        return ["Device-Id": deviceID]
    }

    var sampleData: Data {
        Data()
    }
}

extension TargetType {
    var deviceID: String {
        if let id = UserDefaultStorage<String>().read(key: .deviceID) {
            return id
        } else {
            fatalError()
        }
    }
}
