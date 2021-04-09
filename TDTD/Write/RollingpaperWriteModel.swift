//
//  RollingpaperWriteModel.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/01.
//

import Foundation
import Moya

struct RollingpaperWriteModel {
    var nickname: String?
    var roomType: RoomType
    var message: String?
    var voice: Data?
    var stickerColor: CharacterAsset.Color
    var stickerAngle: Int
    
    init(roomType: RoomType) {
        self.roomType = roomType
        stickerColor = CharacterAsset.randomColor
        stickerAngle = Int.random(in: -10...10)
    }
    
    var isEmptyData: Bool {
        switch roomType {
        case .text:
            return message == nil
        case .voice:
            return voice == nil
        case .none:
            return true
        }
    }
    
    var multipartData: [MultipartFormData] {
        let parameters: [String: Any] = [
            "nickname": nickname!,
            "message_type": roomType.rawValue,
            "sticker_color": stickerColor.rawValue,
            "sticker_angle": stickerAngle,
        ]
        
        var formData: [MultipartFormData] = []
        for (key, value) in  parameters {
            formData.append(MultipartFormData(provider: .data("\(value)".data(using: .utf8)!), name: key))
        }
        if roomType == .text {
            formData.append(MultipartFormData(provider: .data(message!.data(using: .utf8)!), name: "text_message"))
        } else {
            formData.append(.init(provider: .data(voice!), name: "voice_file", fileName: "voice\(Date().fileFormat)", mimeType: "audio/wav"))
        }
        return formData
    }
}

