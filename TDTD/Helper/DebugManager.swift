//
//  DebugManager.swift
//  TDTD
//
//  Created by 이호찬 on 2021/03/08.
//

import Foundation

func Log<T>(_ object: @autoclosure () -> T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    #if DEBUG
    let value = object()
    let fileURL = NSURL(string: file)?.lastPathComponent ?? "Unknown file"
    let queue = Thread.isMainThread ? "MAIN" : "BG"

    print("🦄 <\(queue)> \(fileURL) \(function)[\(line)]: " + String(describing: value))
    #endif
}
