//
//  RollingpaperModel.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/09.
//

import Foundation

struct RollingpaperModel: Identifiable {
    let id: Int
    let isMine: Bool
    let nickname: String
    let text: String?
    let voiceURL: String?
    let stickerColor: CharacterAsset.Color
    let stickerAngle: Int
    let createAt: Date
    var roomType: RoomType {
        voiceURL == nil ? .text : .voice
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
 "created_at": localdatetime, // required, 코멘트 생성 일자
 */
