//
//  AnalyticsName.swift
//  TDTD
//
//  Created by 남수김 on 2021/05/23.
//

import Foundation

struct AnalyticsScreenName {
    static let home = "Home" // 홈리스트화면
    static let roomDetail = "RoomDetail" // 답장리스트화면
    static let write = "Write" // 답장작성화면
}

struct AnalyticsEventName {
    static let createRoom = "CreateRoom" // 방만들시 "value": "TEXT" or "value": "VOICE"
    static let copyLink = "CopyLink" // 링크복사시 "value": "copy"
    static let exitRoom = "ExitRoom" // 방나가기시 value: "host" or value: "user"
    static let removeMessage = "RemoveMessage" // 답장삭제시 value: "host" or value: "user"
    static let favorite = "Favorite" // 즐겨찾기클릭시 value: "on" or value: "off"
}
