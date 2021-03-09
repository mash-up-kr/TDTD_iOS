//
//  RollingpaperModel.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/09.
//

import Foundation

struct RollingpaperModel: Identifiable {
    let id: String
    let nickname: String
    let duration: String?
    let voice: Data?
    let text: String?
    let roomType: RoomType
    
    init(id: String, nickname: String, duration: String? = nil, voice: Data? = nil, text: String? = nil) {
        self.id = id
        self.nickname = nickname
        self.duration = duration
        self.voice = voice
        self.text = text
        roomType = voice == nil ? .text : .voice
    }
}

/*
 "id"             : long,          // required, comment id값
 "is_mine"        : boolean,       // required, 본인 코멘트 여부
 "nickname"       : string,        // required, 닉네임
 "text"           : string,        // optional, TTS로 읽어줄 텍스트
 "voice_file_url" : string,        // optional, 음성 파일 url
 "sticker_color"  : enum,          // required, 스티커 색상
 "sticker_angle"  : int,           // required, 스티커 회전 각도
 "created_at"
 */
