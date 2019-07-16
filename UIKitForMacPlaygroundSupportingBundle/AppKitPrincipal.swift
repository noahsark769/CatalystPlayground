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

    func moveWindowRight() {
        let firstWindow = NSApplication.shared.windows.first!
        let currentFrame = firstWindow.frame
        let newFrame = currentFrame.offsetBy(dx: 50, dy: 0)
        firstWindow.setFrame(newFrame, display: false, animate: true)
    }

    func customToolbarItem(callback: @escaping (String) -> Void) -> NSToolbarItem {
        let item = DetailTypeToolbarItem(itemIdentifier: NSToolbarItem.Identifier(rawValue: "other"), handler: callback)
        return item
    }

    func setUIKit(_ bridge: UIKitBridge) {
        self.bridge = bridge
    }

    @objc private func didSelectFromPopup(_ sender: NSPopUpButton) {
        self.bridge.didSelectDetailType(sender.titleOfSelectedItem ?? "")
    }
}

class DetailTypeToolbarItem: NSToolbarItem, DetailToolbarItemInterface {
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
