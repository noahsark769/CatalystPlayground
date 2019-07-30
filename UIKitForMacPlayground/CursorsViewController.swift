//
//  CursorsViewController.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/17/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation
import UIKit

final class CursorPointerGestureRegocnizerTarget {
    @objc func handleHover(_ sender: UIHoverGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            AppDelegate.shared.bridge?.setPointerCursor()
        case .ended:
            AppDelegate.shared.bridge?.setDefaultCursor()
        default:
            break
        }
    }
}

final class CursorPointerGestureRecognizer: UIHoverGestureRecognizer {
    private let target: CursorPointerGestureRegocnizerTarget
    init() {
        let target = CursorPointerGestureRegocnizerTarget()
        self.target = target
        super.init(target: target, action: #selector(CursorPointerGestureRegocnizerTarget.handleHover(_:)))
    }
}

final class CursorsViewController: ExamplesViewController {
    let colorView = ColorView(color: .systemPink, dimension: 100)
    weak var bridge: AppKitObjcBridge? = nil

    override func viewDidLoad() {
        bridge = AppDelegate.shared.bridge
        if bridge != nil {
            self.views = [
                .paragraph(text: "This square changes the cursor when hovering over it."),
                .paragraph(text: "Also, all the buttons in this app change the cursor to a pointer when they're hovered over."),
                .view(view: colorView)
            ]
        } else {
            self.views = [
                .paragraph(text: "Cursors are not supported in non-AppKit runtime contexts."),
                .view(view: colorView)
            ]
        }
        super.viewDidLoad()

        colorView.addGestureRecognizer(UIHoverGestureRecognizer(target: self, action: #selector(handleHover(_:))))
    }

    @objc private func handleHover(_ sender: UIHoverGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            AppDelegate.shared.bridge?.setPointerCursor()
        case .ended:
            AppDelegate.shared.bridge?.setDefaultCursor()
        default:
            break
        }
    }
}
