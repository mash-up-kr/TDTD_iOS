//
//  RoomSummary.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/28.
//

import Foundation

struct RoomSummary: Codable {
    let isHost: Bool
    let title: String?
    let roomCode: String?
    var isBookmark: Bool
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case isHost = "host"
        case roomCode = "roomCode"
        case isBookmark = "bookmark"
        case createdAt = "createdAt"
    }
}
