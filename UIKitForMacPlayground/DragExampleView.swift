//
//  DragExampleView.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/15/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation
import UIKit

final class DragColorView: ColorView {
    init(color: UIColor) {
        super.init(color: color, dimension: 70)
        let interaction = UIDragInteraction(delegate: self)
        self.addInteraction(interaction)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DragColorView: UIDragInteractionDelegate {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider(object: self.color))]
    }
}

final class DragExampleView: UIView {
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
            let colorView = DragColorView(color: color)
            stackView.addArrangedSubview(colorView)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

//        let view = DragColorView(color: UIColor.purple)
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
