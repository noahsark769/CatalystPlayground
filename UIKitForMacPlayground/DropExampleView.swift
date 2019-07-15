//
//  DropExampleView.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/15/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation
import UIKit

final class DropColorView: ColorView {
    init(color: UIColor) {
        super.init(color: color, dimension: 100)
        let interaction = UIDropInteraction(delegate: self)
        self.addInteraction(interaction)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DropColorView: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIColor.self)
    }

    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: UIColor.self) { colors in
            let color = colors.first as! UIColor
            self.color = color
        }
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
}

final class DropExampleView: UIView {
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 40
        return view
    }()

    init() {
        super.init(frame: .zero)

        self.addSubview(stackView)

        for color in [UIColor.red, UIColor.blue, UIColor.green] {
            let colorView = DropColorView(color: color)
            stackView.addArrangedSubview(colorView)
        }

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

//        let view = DropColorView(color: UIColor.systemPink)
//        self.addSubview(view)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
