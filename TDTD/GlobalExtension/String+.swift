//
//  String+.swift
//  TDTD
//
//  Created by 남수김 on 2021/04/21.
//

import Foundation

extension String {
    var convertSlashDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = formatter.date(from: self) {
            formatter.dateFormat = "yyyy/MM/dd"
            return formatter.string(from: date)
        }
        return ""
    }
    
    var convertKORDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = formatter.date(from: self) {
            formatter.dateFormat = "yyyy년 MM월 dd일"
            return formatter.string(from: date)
        }
        return ""
    }
}
