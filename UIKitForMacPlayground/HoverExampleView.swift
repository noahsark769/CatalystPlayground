//
//  HoverExampleView.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/15/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation
import UIKit

final class HoverColorView: ColorView {
    let hoverColor: UIColor
    let originalColor: UIColor

    init(color: UIColor, hoverColor: UIColor) {
        self.hoverColor = hoverColor
        self.originalColor = color

        super.init(color: color, dimension: 70)
        let recognizer = UIHoverGestureRecognizer(target: self, action: #selector(handleHover(_:)))
        self.addGestureRecognizer(recognizer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func handleHover(_ sender: UIHoverGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            self.color = self.hoverColor
        case .ended:
            self.color = self.originalColor
        default:
            break
        }
    }
}

final class HoverExampleView: UIView {
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 40
        return view
    }()

    init() {
        super.init(frame: .zero)

        self.addSubview(stackView)

        for (color, hoverColor) in [(UIColor.red, UIColor.blue), (UIColor.blue, UIColor.green), (UIColor.green, UIColor.red)] {
            let colorView = HoverColorView(color: color, hoverColor: hoverColor)
            stackView.addArrangedSubview(colorView)
        }

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
