//
//  DetailType.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/16/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation

enum DetailType: String, CaseIterable {
    case keyboardShortcuts = "Keyboard Shortcuts"
    case windows = "Windows"
    case hover = "Hover"
    case dragAndDrop = "Drag and drop"
    case touchBar = "Touch bar"
    case contextMenus = "Context menus"
}

@objc protocol UIKitBridge {
    func didSelectDetailType(_ detailTypeString: String)
}

protocol DetailToolbarItemInterface {
    func setSelected(_ detailType: DetailType)
}

extension Notification.Name {
    static let didChangeDetailType = Notification.Name("didChangeDetailType")
}