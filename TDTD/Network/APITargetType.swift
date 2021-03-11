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
        guard let url = URL(string: "http://52.79.54.20") else { fatalError("Wrong URL") }
        return url
    }

    var headers: [String: String]? {
        return ["Device-Id": "device-1"]
    }

    var sampleData: Data {
        Data()
    }
}
