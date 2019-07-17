//
//  TouchBarViewController.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/16/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation

final class TouchBarViewController: ExamplesViewController {
    let colorView = ColorView(color: .red, dimension: 100)

    override func viewDidLoad() {
        self.views = [
            .paragraph(text: "This view controller provides touch bar items. Use them to modify the color of this square."),
            .view(view: colorView)
        ]
        super.viewDidLoad()
    }
}

#if targetEnvironment(macCatalyst)
import AppKit

extension TouchBarViewController: NSTouchBarProvider {
    var touchBar: NSTouchBar? {
        let bar = NSTouchBar()
        let buttonIdentifier = NSTouchBarItem.Identifier(rawValue: "clickme")
        let colorIdentifier = NSTouchBarItem.Identifier(rawValue: "color")
        bar.defaultItemIdentifiers = [
            buttonIdentifier,
            colorIdentifier
        ]
        let colorPicker = NSColorPickerTouchBarItem.strokeColorPicker(withIdentifier: colorIdentifier)
        colorPicker.target = self
        colorPicker.action = #selector(didPickColor)
        bar.templateItems = [
            NSButtonTouchBarItem(
                identifier: buttonIdentifier,
                title: "Random color",
                target: self,
                action: #selector(didTapRandomColor)
            ),
            colorPicker
        ]
        return bar
    }

    @objc private func didTapRandomColor(_ sender: NSTouchBarItem) {
        self.colorView.color = generateRandomColor()
    }

    @objc private func didPickColor(_ sender: NSColorPickerTouchBarItem) {
        self.colorView.color = sender.color
    }
}
#endif
