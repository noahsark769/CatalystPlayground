//
//  HoverViewController.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/15/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation
import AppKit
import UIKit

class HoverViewController: ExamplesViewController {
    override func viewDidLoad() {
        self.views = [
            .paragraph(text: "The following squares change color when you hover over them."),
            .view(view: HoverExampleView())
        ]

        super.viewDidLoad()
    }
}
