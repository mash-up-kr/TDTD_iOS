//
//  ResponseModel.swift
//  TDTD
//
//  Created by 남수김 on 2021/04/04.
//

import Foundation

struct ResponseModel<T> {
    let message: String
    let result: T
    let code: Int
}
