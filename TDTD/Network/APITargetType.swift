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
        guard let url = URL(string: "https://sokdak.site") else { fatalError("Wrong URL") }
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
