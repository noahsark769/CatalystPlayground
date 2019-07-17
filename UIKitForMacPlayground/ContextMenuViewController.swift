//
//  ContextMenuViewController.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/16/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation
import UIKit

final class ContextMenuViewController: ExamplesViewController {
    let colorView = ColorView(color: .systemTeal, dimension: 100)

    override func viewDidLoad() {
        self.views = [
            .paragraph(text: "This square has a context menu (right click to trigger)"),
            .view(view: colorView)
        ]
        super.viewDidLoad()

        colorView.addInteraction(UIContextMenuInteraction(delegate: self))
    }
}

extension ContextMenuViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
            return UIMenu(__title: "Menu", image: nil, identifier: nil, children: [
                UIAction(__title: "Change to random color", image: UIImage(systemName: "square.and.arrow.up"), identifier: UIAction.Identifier(rawValue: "open"), handler: { action in
                    self.colorView.color = generateRandomColor()
                }),
                UIMenu(title: "Predefined colors", image: nil, identifier: nil, children: [
                    (string: "Red", color: UIColor.systemRed),
                    (string: "Blue", color: UIColor.systemBlue),
                    (string: "Green", color: UIColor.systemGreen)
                ].map { config in
                    UIAction(__title: config.string, image: nil, identifier: UIAction.Identifier(rawValue: "open-\(config.string)"), handler: { action in
                        self.colorView.color = config.color
                    })
                })
            ])
        })
    }
}
