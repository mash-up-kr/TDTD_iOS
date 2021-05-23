//
//  RoomType.swift
//  TDTD
//
//  Created by juhee on 2021/02/27.
//

import UIKit


enum RoomType: String {
    
    case none = "NONE"
    case voice = "VOICE"
    case text = "TEXT"
    
    var title: String {
        switch self {
        case .none:     return ""
        case .voice:    return "음성"
        case .text:     return "텍스트"
        }
    }
    
    var description: String {
        switch self {
        case .none:     return ""
        case .voice:    return "직접 음성 녹음을\n할 수 있어요!"
        case .text:     return "텍스트로 메세지를 써서\n마음을 속닥여요!"
        }
    }
    
    var image: String {
        switch self {
        case .none:     return ""
        case .voice:    return "img_room_voice"
        case .text:     return "img_room_text"
        }
    }
    
}
