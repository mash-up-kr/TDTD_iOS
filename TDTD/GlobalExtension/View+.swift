//
//  View+.swift
//  TDTD
//
//  Created by 남수김 on 2021/03/01.
//

import SwiftUI
import UIKit

extension View {
    func hideKeyboard() -> some View {
        onTapGesture {
            UIApplication.shared.windows.forEach{ $0.endEditing(true) }
        }
    }
}

