//
//  ExamplesViewController.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/15/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation
import UIKit

/// Subclasses extend this controller to provide standard components  in a list (ViewType instances)
class ExamplesViewController: UIViewController {
    typealias ButtonHandler = (ExamplesViewController) -> Void
    enum ViewType {
        case header(text: String)
        case paragraph(text: String)
        case button(text: String, color: UIColor, didTap: ButtonHandler)
        case view(view: UIView)
    }

    var views: [ViewType] = []

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.alignment = .leading
        return view
    }()

    private var buttonUUIDHashValuesToActions: [Int: ButtonHandler] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.systemBackground

        for view in views {
            switch view {
            case let .header(text):
                stackView.addArrangedSubview(HeaderView(text: text))
            case let .paragraph(text):
                let label = UILabel()
                label.textColor = .label
                label.text = text
                label.numberOfLines = 0
                stackView.addArrangedSubview(label)
            case let .button(text, color, didTap):
                let button = UIButton()
                let uid = HashableIdGenerator.next()
                button.setTitle(text, for: .normal)
                button.tag = uid
                button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
                button.setTitleColor(color, for: .normal)
                buttonUUIDHashValuesToActions[uid] = didTap
                stackView.addArrangedSubview(button)
            case let .view(view):
                stackView.addArrangedSubview(view)
            }
        }

        self.view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        let trailingConstraint = stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50)
        trailingConstraint.priority = .defaultHigh
        trailingConstraint.isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    }

    @objc private func didTapButton(_ sender: UIButton) {
        let hashValue = sender.tag
        guard let handler = buttonUUIDHashValuesToActions[hashValue] else {
            return
        }
        handler(self)
    }
}
