//
//  SceneDelegate.swift
//  SilentWake
//
//  Created by Ok Hyeon Kim on 2023/05/03.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private let provider = ServiceProvider()
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else {
            return
        }

        let window = UIWindow(windowScene: scene)

        let mainReactor = MainReactor(provider: provider)
        let mainViewController = MainViewController(reactor: mainReactor)

        window.rootViewController = mainViewController
        window.makeKeyAndVisible()
        self.window = window
    }
}

