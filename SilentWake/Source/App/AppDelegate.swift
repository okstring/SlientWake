//
//  AppDelegate.swift
//  SilentWake
//
//  Created by Ok Hyeon Kim on 2023/05/03.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let provider = ServiceProvider()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            return true
        }

        let mainReactor = MainReactor(provider: provider)
        let mainViewController = MainViewController(reactor: mainReactor)

        window = UIWindow()
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
        return true
    }
}

