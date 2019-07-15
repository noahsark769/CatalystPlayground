//
//  ColorView.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/15/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import UIKit

class ColorView: UIView {
    var color: UIColor {
        didSet {
            self.backgroundColor = color
        }
    }

    init(color: UIColor, dimension: CGFloat? = nil) {
        self.color = color
        super.init(frame: .zero)

        self.backgroundColor = color

        if let dimension = dimension {
            self.widthAnchor.constraint(equalToConstant: dimension).isActive = true
            self.heightAnchor.constraint(equalToConstant: dimension).isActive = true
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
