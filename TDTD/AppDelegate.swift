//
//  AppDelegate.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/19.
//

import UIKit
import Firebase
import GoogleMobileAds
import AppTrackingTransparency

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        let storage = UserDefaultStorage<String>()
        
        if let deviceID = storage.read(key: .deviceID) {
                Log("📌deviceID: \(deviceID)")
        } else {
            let deviceID = UUID().uuidString
            storage.write(deviceID, key: .deviceID)
        }
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization {
                switch $0 {
                case .authorized:
                    print("auth")
                case .denied:
                    print("denied")
                case .notDetermined:
                    print("not determind")
                case .restricted:
                    print("restrict")
                default:
                    print("default")
                }
            }
        }
        
        // Initialize the Google Mobile Ads SDK.
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

