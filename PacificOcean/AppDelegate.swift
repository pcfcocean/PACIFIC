//
//  AppDelegate.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 24.12.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - UIApplicationDelegate properties
    var window: UIWindow?

    let coordinator = MVVM_Coordinator(assembly: MVVM_Assembly())

    // MARK: - UIApplicationDelegate methods
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
//
//        let navigationController: UINavigationController = UINavigationController(rootViewController: ARCH.mvc.viewController)
//        window.rootViewController = navigationController
//        window.makeKeyAndVisible()
        coordinator.start(window: window)

        AsincAwait()

        return true
    }
}
