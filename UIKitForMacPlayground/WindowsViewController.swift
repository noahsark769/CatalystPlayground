//
//  WindowsViewCotroller.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/5/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation
import AppKit
import UIKit

enum UserActivities: String {
    case square = "com.noahgilmore.uikitformacplayground.square"
}

final class HeaderView: UIView {
    init(text: String) {
        super.init(frame: .zero)

        let label = UILabel()
        label.textColor = .label
        label.text = text
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ExampleViewController: UIViewController {
    typealias ButtonHandler = (ExampleViewController) -> Void
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

enum HashableIdGenerator {
    private static var nextId = 0

    static func next() -> Int {
        nextId += 1
        return nextId
    }
}

class WindowsViewController: ExampleViewController {
    override func viewDidLoad() {
        self.views = [
            .paragraph(text: "You can jump to this page at any time using Command J or selecting Jump To -> Windows from the menu bar."),
            .header(text: "Creation/deletion"),
            .button(text: "Launch new window (Cmd-N equivalent)", color: .systemBlue, didTap: { _ in
                UIApplication.shared.requestSceneSessionActivation(nil, userActivity: nil, options: nil, errorHandler: nil)
            }),
            .button(text: "Close current window (Cmd-W equivalent)", color: .systemRed, didTap: { _ in
                guard let containingScene = self.view.window?.windowScene else { return }
                UIApplication.shared.requestSceneSessionDestruction(containingScene.session, options: nil, errorHandler: nil)
            }),
            .header(text: "Different window types"),
            .button(text: "Launch a new single-color window", color: .systemBlue, didTap: { _ in
                let activity = NSUserActivity(activityType: UserActivities.square.rawValue)
                UIApplication.shared.requestSceneSessionActivation(nil, userActivity: activity, options: nil, errorHandler: nil)
            })
        ]

        super.viewDidLoad()
    }
}
