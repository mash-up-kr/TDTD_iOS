//
//  RollingpaperWriteModel.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/01.
//

import Foundation

struct RollingpaperWriteModel {
    var nickName: String?
    var mode: WriteMode
    var message: String?
    var voice: Data?
    
    init(mode: WriteMode) {
        self.mode = mode
    }
    
    var isEmptyData: Bool {
        switch mode {
        case .text:
            return message == nil
        case .voice:
            return voice == nil
        }
    }
}
