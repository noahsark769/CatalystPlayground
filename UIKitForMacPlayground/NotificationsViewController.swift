//
//  NotificationsViewController.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/30/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class NotificationsViewController: ExamplesViewController {
    override func viewDidLoad() {
        self.views = [
            .paragraph(text: "This button shows a local notification."),
            .button(text: "Show notification", color: .systemBlue, didTap: { _ in
                    self.requestAndTriggerNotification()
                }
            )
        ]

        super.viewDidLoad()
    }

    func requestAndTriggerNotification() {
        let center = UNUserNotificationCenter.current()
        // Request permission to display alerts and play sounds.
        // Note: if the app is in the foreground, this will trigger the AppDelegate's
        // UNUserNotificationCenterDelegate method, which will call the completionHandler
        // to display the default notification UI. If the app is in the background, the
        // default notification UI will be displayed without calling the AppDelegate
        center.requestAuthorization(options: [.badge, .sound, .alert]) { (granted, error) in
            if granted {
                self.triggerNotification()
            }
        }
    }

    func triggerNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is a notification"
        content.body = "This is the notification body"
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: nil)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("User notification error: \(error)")
            }
        }
    }
}
