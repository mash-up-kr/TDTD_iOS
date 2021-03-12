//
//  NetworkLogger.swift
//  TDTD
//
//  Created by 이호찬 on 2021/03/08.
//

import Foundation
import Alamofire

final class NetworkLogger {
    static let shared = NetworkLogger()

    var filterPredicate: NSPredicate?

    private var startDates: NSMutableDictionary

    init() {
        startDates = NSMutableDictionary()
    }

    deinit {
        stopLogging()
    }

}

extension NetworkLogger {
    func startLogging() {
        stopLogging()

        let notificationCenter = NotificationCenter.default

        notificationCenter.addObserver(
            self,
            selector: #selector(NetworkLogger.networkRequestDidStart(notification:)),
            name: Request.didResumeTaskNotification,
            object: nil
        )

        notificationCenter.addObserver(
            self,
            selector: #selector(NetworkLogger.networkRequestDidComplete(notification:)),
            name: Request.didCompleteTaskNotification,
            object: nil
        )
    }

    func stopLogging() {
        NotificationCenter.default.removeObserver(self)
    }
}

extension NetworkLogger {
    @objc private func networkRequestDidStart(notification: Notification) {
        guard let task = notification.request?.task,
            let dataRequest = notification.request as? DataRequest,
            let request = dataRequest.request,
            let httpMethod = request.httpMethod,
            let requestURL = request.url else { return }

        if let filterPredicate = filterPredicate, filterPredicate.evaluate(with: request) {
            return
        }

        startDates[task] = Date()
        Log("<-- \(httpMethod) '\(requestURL.absoluteString)':")
        
        if let httpHeadersFields = request.allHTTPHeaderFields {
            for (key, value) in httpHeadersFields {
                Log("\(key): \(value)")
            }
        }
        
        if let httpBody = request.httpBody, let httpBodyString = String(data: httpBody, encoding: .utf8) {
            Log(httpBodyString)
        }
    }

    @objc private func networkRequestDidComplete(notification: Notification) {
        guard let task = notification.request?.task,
            let dataRequest = notification.request as? DataRequest,
            let request = dataRequest.request,
            let httpMethod = request.httpMethod,
            let requestURL = request.url else { return }

        if let filterPredicate = filterPredicate, filterPredicate.evaluate(with: request) {
            return
        }

        var elapsedTime: TimeInterval = 0.0

        if let dates = startDates as? [URLSessionTask: Date], let startDate = dates[task] {
            elapsedTime = Date().timeIntervalSince(startDate)
            startDates.removeObject(forKey: task)
        }

        if let error = task.error {
                Log("--> [Error] \(httpMethod) '\(requestURL.absoluteString)' [\(String(format: "%.04f", elapsedTime)) s]:")
                Log(error)
        } else {
            guard let response = task.response as? HTTPURLResponse else {
                return
            }
            Log("--> \(String(response.statusCode)) '\(requestURL.absoluteString)' [\(String(format: "%.04f", elapsedTime)) s]:")

            guard let data = dataRequest.data else { return }

            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)

                if let prettyString = String(data: prettyData, encoding: .utf8) {
                    Log(prettyString)
                }
            } catch {
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    Log(string)
                }
            }
        }
    }
}
