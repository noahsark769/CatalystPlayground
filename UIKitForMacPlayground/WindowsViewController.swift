//
//  WindowsViewCotroller.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/5/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation
import UIKit

extension Notification.Name {

}

class WindowsViewController: ExamplesViewController {
    override func viewDidLoad() {
        self.views = [
            .paragraph(text: "You can jump to this page at any time using Command J or selecting Jump To -> Windows from the menu bar."),
            .header(text: "Creation/deletion"),
            .button(text: "Launch new window (Cmd-N equivalent)", color: .systemBlue, didTap: { _ in
                UIApplication.shared.requestSceneSessionActivation(nil, userActivity: nil, options: nil, errorHandler: nil)
            }),
            .button(text: "Close current window (Cmd-W equivalent)", color: .systemRed, didTap: { _ in
                guard let containingScene = self.view.window?.windowScene else { return }
                UIApplication.shared.requestSceneSessionDestruction(containingScene.session, options: nil, errorHandler: nil)
            }),
            .header(text: "Different window types"),
            .button(text: "Launch a new single-color window", color: .systemBlue, didTap: { _ in
                let activity = NSUserActivity(activityType: UserActivities.square.rawValue)
                UIApplication.shared.requestSceneSessionActivation(nil, userActivity: activity, options: nil, errorHandler: nil)
            }),
            .header(text: "Window management"),
            .button(text: "Move this window 50pt to the right", color: .systemBlue, didTap: { _ in
                NotificationCenter.default.post(name: Notification.Name(rawValue: "appkitbridge"), object: nil)
            })
        ]

        super.viewDidLoad()
    }
}
