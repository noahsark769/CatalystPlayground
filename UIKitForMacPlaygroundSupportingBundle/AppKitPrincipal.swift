//
//  AppKitPrincipal.swift
//  UIKitForMacPlaygroundSupportingBundle
//
//  Created by Noah Gilmore on 7/15/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation
import AppKit

class AppKitPrincipal: NSObject, AppKitObjcBridge {
    private var bridge: UIKitBridge! = nil
    private let windowManager = WindowManager()

    func moveWindowRight() {
        let firstWindow = NSApplication.shared.windows.first!
        let currentFrame = firstWindow.frame
        let newFrame = currentFrame.offsetBy(dx: 50, dy: 0)
        firstWindow.setFrame(newFrame, display: false, animate: true)
    }

    func customToolbarItem(identifier: String, callback: @escaping (String) -> Void) -> NSToolbarItem {
        let item = DetailTypeToolbarItem(itemIdentifier: NSToolbarItem.Identifier(rawValue: identifier), handler: callback)
        return item
    }

    func setUIKit(_ bridge: UIKitBridge) {
        self.bridge = bridge
    }

    @objc private func didSelectFromPopup(_ sender: NSPopUpButton) {
        self.bridge.didSelectDetailType(sender.titleOfSelectedItem ?? "")
    }

    func setDefaultCursor() {
        NSCursor.arrow.set()
    }

    func setPointerCursor() {
        NSCursor.pointingHand.set()
    }

    func sceneBecameActive(identifier: String) {
        self.windowManager.sceneBecameActive(identifier: identifier)
    }
}

class DetailTypeToolbarItem: NSToolbarItem {
    private let handler: (String) -> Void

    init(itemIdentifier: NSToolbarItem.Identifier, handler: @escaping (String) -> Void) {
        self.handler = handler
        super.init(itemIdentifier: itemIdentifier)
        let button = NSPopUpButton()
        for type in DetailType.allCases {
            button.addItem(withTitle: type.rawValue)
        }
        button.target = self
        button.action = #selector(didSelectFromPopup)
        self.view = button

        NotificationCenter.default.addObserver(forName: Notification.Name.didChangeDetailType, object: nil, queue: nil, using: { notification in
            guard let detailTypeString = notification.userInfo?["detailType"] as? String else {
                return
            }
            guard let identifier = notification.userInfo?["identifier"] as? String else {
                return
            }
            guard identifier == self.itemIdentifier.rawValue else { return }
            guard let detailType = DetailType(rawValue: detailTypeString) else { return }
            self.setSelected(detailType)
        })
    }

    func setSelected(_ detailType: DetailType) {
        guard let button = self.view as? NSPopUpButton else {
            return
        }
        button.selectItem(withTitle: detailType.rawValue)
    }

    @objc private func didSelectFromPopup(_ sender: NSPopUpButton) {
        guard let selectedTitle = sender.titleOfSelectedItem else { return }
        self.handler(selectedTitle)
    }
}

class RedView: NSView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.systemRed.setFill()
        dirtyRect.fill()
    }
}

/// TODO: This is a hacky way to track and get references to windows between UIKit and AppKit. There's probably a much better way.
class WindowManager {
    private var windows: [Int: NSWindow] = [:]

    func sceneBecameActive(identifier: String) {
        var newWindows: [Int: NSWindow] = [:]
        for window in NSApplication.shared.windows {
            if !windows.keys.contains(window.windowNumber) {
                print("BECOMING ACTIVE: \(window.windowNumber), \(identifier)")
                self.handleWindowAppearance(identifier: identifier, window: window)
            }
            newWindows[window.windowNumber] = window
        }
        windows = newWindows
    }

    func handleWindowAppearance(identifier: String, window: NSWindow) {
        if identifier == "square" {
            window.setContentSize(NSSize(width: 200, height: 200))
            window.styleMask.remove(.resizable)
        }
    }
}
