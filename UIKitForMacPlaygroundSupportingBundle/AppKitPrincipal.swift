//
//  AppKitPrincipal.swift
//  UIKitForMacPlaygroundSupportingBundle
//
//  Created by Noah Gilmore on 7/15/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation
import AppKit

class AppKitPrincipal: NSObject {
    override init() {
        super.init()

        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "appkitbridge"), object: nil, queue: nil) { _ in
            let firstWindow = NSApplication.shared.windows.first!
            let currentFrame = firstWindow.frame
            let newFrame = currentFrame.offsetBy(dx: 50, dy: 0)
            firstWindow.setFrame(newFrame, display: false, animate: true)
        }
    }
}
