//
//  AppDelegate.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 6/27/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        let configuration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    override func buildCommands(with builder: UICommandBuilder) {
        builder.insertChild(UICommandGroup(
            __title: "TEST GROUP",
            discoverabilityTitle: "Group",
            identifier: UIMenu.Identifier("hey"),
            options: [],
            children: [
                UIKeyCommand(
                    input: "A",
                    modifierFlags: [.command],
                    action: #selector(AppDelegate.testSelected(_:))
                )
            ]
        ), atEndOfGroup: .file)
    }

    @objc private func testSelected(_ sender: AppDelegate) {
        print("TEST!!")
    }
}

