//
//  URL+.swift
//  TDTD
//
//  Created by 남수김 on 2021/04/21.
//

import Foundation

extension URL {
    var queryItems: [String: String] {
        guard let urlComponent = URLComponents(string: self.absoluteString),
              let items = urlComponent.queryItems else {
            return [:]
        }
    
        var query: [String: String] = [:]
        for item in items {
            query[item.name] = item.value
        }
        return query
    }
}
