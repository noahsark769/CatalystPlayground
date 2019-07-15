//
//  DragAndDropViewController.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/15/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation
import UIKit

class DragAndDropViewController: ExamplesViewController {
    override func viewDidLoad() {
        self.views = [
            .paragraph(text: "These squares are drag targets: drag them into the drop targets to set color (even across windows)."),
            .view(view: DragExampleView()),
            .paragraph(text: "These squares are drop targets: drag a drag target onto them to set their color (even across windows)"),
            .view(view: DropExampleView()),
        ]

        super.viewDidLoad()
    }
}

