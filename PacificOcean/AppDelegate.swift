//
//  AppDelegate.swift
//  PacificOcean
//
//  Created by Vlad Lesnichiy on 24.12.23.
//

import UIKit
import AppMetricaCore

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
        
        window.rootViewController = LoaderVC()
        window.makeKeyAndVisible()

        //        Combine_2()

        //        let appMetricaPACIFIC = AppMetricaPACIFIC()
        //        appMetricaPACIFIC.start()
        //        appMetricaPACIFIC.testData()

        //        SwitchTest().свитч()
        //        Solution0003().lengthOfLongestSubstring("dvdf")
//        Combine_3()
//        Crashes()

        return true
    }
}
