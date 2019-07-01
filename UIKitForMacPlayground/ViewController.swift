//
//  ViewController.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 6/27/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import UIKit
import AppKit

class ViewController: UIViewController, NSTouchBarProvider {
    var touchBar: NSTouchBar? {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
    }

    @objc private func didTapClickMe(_ sender: NSTouchBarItem) {
        print("Click me!!!")
    }

    override func buildCommands(with builder: UICommandBuilder) {
        builder.insertChild(UICommandGroup(
            __title: "TEST GROUP 2",
            discoverabilityTitle: "Group 2",
            identifier: UIMenu.Identifier("hey2"),
            options: [],
            children: [
                UIKeyCommand(
                    input: "R",
                    modifierFlags: [.command],
                    action: #selector(ViewController.testSelected(_:))
                )
            ]
        ), atEndOfGroup: .file)
    }

    @objc private func testSelected(_ sender: AppDelegate) {
        print("TEST!!")
    }
}

//extension ViewController: NSTouchBarDelegate {
//    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
//        if identifier.rawValue == "something" {
//            return NSButtonTouchBarItem(identifier: identifier, title: "Click me", image: UIImage(systemName: "hurricane")!, target: self, action: #selector(didTapClickMe(_:)))
//        }
//        return nil
//    }
//
//    @objc private func didTapClickMe(_ sender: NSTouchBarItem) {
//        print("Click me!!!")
//    }
//}
