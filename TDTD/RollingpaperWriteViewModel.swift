//
//  RollingpagerWriteViewModel.swift
//  TDTD
//
//  Created by 남수김 on 2021/02/27.
//

import Foundation

class RollingpaperWriteViewModel {
    enum WriteMode {
        case text, voice
    }
    
    let mode: WriteMode
    
    init(mode: WriteMode = .text) {
        self.mode = mode
    }
    
}
