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
    func moveWindowRight() {
        let firstWindow = NSApplication.shared.windows.first!
        let currentFrame = firstWindow.frame
        let newFrame = currentFrame.offsetBy(dx: 50, dy: 0)
        firstWindow.setFrame(newFrame, display: false, animate: true)
    }

    func customToolbarItem() -> NSToolbarItem {
        let item = NSToolbarItem(itemIdentifier: NSToolbarItem.Identifier(rawValue: "other"))
        item.title = "OTHER"
        let button = NSPopUpButton()
        button.addItem(withTitle: "This NSPopupButton comes from AppKit")
        button.addItem(withTitle: "The choices don't do anything")
        button.addItem(withTitle: "But it serves as a nice demonstration")
        item.view = button
        return item
    }
}

class RedView: NSView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.systemRed.setFill()
        dirtyRect.fill()
    }
}
