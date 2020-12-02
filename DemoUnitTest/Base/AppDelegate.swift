//
//  AppDelegate.swift
//  DemoUnitTest
//
//  Created by Thuy Nguyen T.H on 11/4/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let inputVC = InputInfoViewController()
        let navi = UINavigationController(rootViewController: inputVC)

        window?.rootViewController = navi
        window?.makeKeyAndVisible()
        return true
    }

}

