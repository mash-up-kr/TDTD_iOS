//
//  CreateRoomViewModel.swift
//  TDTD
//
//  Created by juhee on 2021/02/27.
//

import Foundation
import SwiftUI
import Combine

import FirebaseAnalytics

class CreateRoomViewModel: ObservableObject {
    
    @Published var type: RoomType = .none
    @Published var title: String = ""
    @Published var isCreated: Bool = false
    
    private var requestMakeRoomCancellable: AnyCancellable?
    
    private(set) var newRoomCode: String?
    private var isLoading: Bool = false
    
    func updateRoom(type: RoomType) {
        self.type = type
    }
    
    func isRoom(type: RoomType) -> Bool {
        return self.type == type
    }
    
    func createRoom() {
        requestMakeRoom()
    }
}


extension CreateRoomViewModel {
    private func requestMakeRoom() {
        if isLoading {
            return
        }
        requestMakeRoomCancellable?.cancel()
        isLoading = true
        requestMakeRoomCancellable = APIRequest.shared.requestMakeRoom(title: title, type: type)
            .sink(receiveCompletion: { _ in }
                  , receiveValue: { [weak self] in
                    if let data = try? $0.map(ResponseModel<[String:String]>.self) {
                        if data.code == 2000 {
                            Analytics.logEvent(AnalyticsEventName.createRoom,
                                               parameters: ["value": self?.type.rawValue ?? "none"])
                            self?.newRoomCode = data.result["room_code"]
                            self?.isCreated = true
                        }
                    }
                    self?.isLoading = false
                  })
    }
}
