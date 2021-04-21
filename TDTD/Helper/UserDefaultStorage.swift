//
//  UserDefaultStorage.swift
//  TDTD
//
//  Created by 남수김 on 2021/04/21.
//

import Foundation

struct UserDefaultStorage<T> {
    /**
     `data`가 `nil` 인 경우 해당 경로의 데이터를 삭제합니다.
     */
    func write(_ data: T?, key: UserDefaultKey) {
        if let data = data {
            UserDefaults.standard.set(data, forKey: key.rawValue)
        } else {
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
    
    func read(key: UserDefaultKey) -> T? {
        if let data = UserDefaults.standard.object(forKey: key.rawValue) as? T {
            return data
        } else {
            return nil
        }
    }
}

enum UserDefaultKey: String {
    case deviceID
}

