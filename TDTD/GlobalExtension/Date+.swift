//
//  Date+.swift
//  TDTD
//
//  Created by 남수김 on 2021/02/26.
//

import Foundation

extension Date {
    var fileFormat: String {
        let format: DateFormatter = DateFormatter()
        format.dateFormat = "yyyyMMddhhmmss"
        
        return format.string(from: self)
    }
}
