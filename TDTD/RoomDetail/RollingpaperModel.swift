//
//  RollingpaperModel.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/09.
//

import Foundation

struct RoomResponse: Decodable {
    let title: String  // required, 방 제목
    let type: String // required, 방 유형
    let isHost: Bool  // required, 방 관리자인지 여부
    let shareURL: String // required, 방 공유 링크
    let comments: [RollingpaperResponse]
    
    enum CodingKeys: String, CodingKey {
        case title, type
        case isHost = "is_host"
        case shareURL = "share_url"
        case comments
    }
}

struct RollingpaperResponse: Decodable {
    let id: Int
    let isMine: Bool
    let nickname: String
    let text: String?
    let voiceURL: String?
    let stickerColor: String
    let stickerAngle: Int
    let createAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case isMine = "is_mine"
        case nickname, text
        case voiceURL = "voice_file_url"
        case stickerColor = "sticker_color"
        case stickerAngle = "sticker_angle"
        case createAt = "created_at"
    }
}

struct RoomModel {
    let title: String  // required, 방 제목
    let type: RoomType // required, 방 유형
    let isHost: Bool  // required, 방 관리자인지 여부
    let shareURL: String // required, 방 공유 링크
    let comments: [RollingpaperModel]
    
    init(model: RoomResponse) {
        title = model.title
        type = RoomType(rawValue: model.type) ?? .none
        isHost = model.isHost
        shareURL = model.shareURL
        comments = model.comments.map { RollingpaperModel(model: $0) }
    }
}

struct RollingpaperModel: Identifiable {
    let id: Int
    let isMine: Bool
    let nickname: String
    let text: String?
    let voiceURL: String?
    let stickerColor: CharacterAsset.Color
    let stickerAngle: Int
    let createAt: Date
    
    init(model: RollingpaperResponse) {
        id = model.id
        isMine = model.isMine
        nickname = model.nickname
        text = model.text
        voiceURL = model.voiceURL
        stickerColor = CharacterAsset.Color(rawValue: model.stickerColor) ?? .lavender
        stickerAngle = model.stickerAngle
        createAt = DateFormatter().date(from: model.createAt) ?? Date()
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
