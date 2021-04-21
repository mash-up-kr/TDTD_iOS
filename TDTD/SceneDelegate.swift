//
//  SceneDelegate.swift
//  TDTD
//
//  Created by Hochan Lee on 2021/02/19.
//

import UIKit
import SwiftUI
import Firebase
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var cancelBag = Set<AnyCancellable>()
    @Published private var isUpdate: Bool?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        
        NetworkLogger.shared.startLogging()
        
        let viewModel = HomeViewModel()
        let contentView = HomeView(viewModel: viewModel)
            .onReceive($isUpdate) {
                if let isUpdate = $0, isUpdate {
                    Log("Deep Link Update")
                    viewModel.requestRooms()
                }
            }

        // MARK: - 네비게이션 설정
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor(ColorPallete.grayscale(1).color),
            NSAttributedString.Key.font: UIFont(name: Font.CustomFontWeight.bold.name, size: 20)!
        ]
        UINavigationBar.appearance().titleTextAttributes = attrs
        UINavigationBar.appearance().barTintColor =  UIColor(named: "beige_1")
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .clear

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    // MARK: -  Deep Link 수신
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let urlToOpen = userActivity.webpageURL else {
              return
          }
        Log(urlToOpen)
        DynamicLinks.dynamicLinks().handleUniversalLink(urlToOpen) { [weak self] (dynamiclink, error) in
            guard let self = self else {
                return
            }
            
            if let redirectURL = dynamiclink?.url {
                Log(redirectURL)
            }
            APIRequest.shared.requestJoinRoom(roomCode: "yqY4KKDKR-6W-wVIJaNeWw")
                .replaceError(with: .init(statusCode: -1, data: Data()))
                .sink { [weak self] response in
                    do {
                        if let responseModel = try response.mapJSON() as? [String: Any] {
                            if responseModel["code"] as? Int != 2000 {
                                Log("Fail JoinRoom")
                                self?.isUpdate = false
                            } else {
                                self?.isUpdate = true
                            }
                            Log(responseModel)
                        }
                    } catch {
                        Log("decode error")
                    }
                }
                .store(in: &self.cancelBag)
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        for context in URLContexts {
            print("url: \(context.url.absoluteURL)")
            print("scheme: \(context.url.scheme)")
            print("host: \(context.url.host)")
            print("path: \(context.url.path)")
            print("components: \(context.url.pathComponents)")
            
            if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: context.url) {
                // Handle the deep link. For example, show the deep-linked content or
                // apply a promotional offer to the user's account.
                // ...
                Log(dynamicLink)
              }
          }
    }
}

