//
//  AppDelegate.swift
//  TopContributors
//
//  Created by Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // init UI
        self.initializeUI()
        return true
    }
    func initializeUI() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let contributorModule = Modules.contributorsList()
        let navigationController = UINavigationController(rootViewController: contributorModule.view)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
