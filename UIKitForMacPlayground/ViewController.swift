//
//  ViewController.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 6/27/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import UIKit

#if targetEnvironment(macCatalyst)
import AppKit
#endif

func generateRandomColor() -> UIColor {
    let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
    let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
    let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black

    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
}

class ViewController: ExamplesViewController {
    override func viewDidLoad() {
        self.views = [
            .paragraph(text: "Press Cmd-R to change the color of this view")
        ]
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = generateRandomColor()
    }

    override var keyCommands: [UIKeyCommand]? {
        return [
            UIKeyCommand(
                input: "R",
                modifierFlags: [.command],
                action: #selector(ViewController.testSelected(_:))
            )
        ]
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    @objc private func testSelected(_ sender: AppDelegate) {
        self.view.backgroundColor = generateRandomColor()
    }
}

#if targetEnvironment(macCatalyst)
extension ViewController: NSTouchBarProvider {
    var touchBar: NSTouchBar? {
        //        return nil
        let bar = NSTouchBar()
        let identifier = NSTouchBarItem.Identifier(rawValue: "clickme")
        bar.defaultItemIdentifiers = [identifier]
        bar.templateItems = [
            NSButtonTouchBarItem(
                identifier: identifier,
                title: "😥",
                target: self,
                action: #selector(didTapClickMe(_:))
            )
        ]
        return bar
    }

    @objc private func didTapClickMe(_ sender: NSTouchBarItem) {
        print("Click me!!!")
    }
}
#endif
