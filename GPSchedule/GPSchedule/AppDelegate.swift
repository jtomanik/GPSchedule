//
//  AppDelegate.swift
//  GPSchedule
//
//  Created by Jakub Tomanik on 07/03/2019.
//  Copyright © 2019 Jakub Tomanik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var store: RootStore = {
        return RootStore(
            initialState: RootState(),
            reducer: RootUseCase())
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }

    private func setupWindow() {
        let bounds = UIScreen.main.bounds
        window = UIWindow(frame: bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = RootViewController(
            viewModel: RootViewModel(
                store: store))
        self.window?.makeKeyAndVisible()
    }
}

