//
//  OpenFileViewController.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/25/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class OpenFileViewController: ExamplesViewController {
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.widthAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
        return view
    }()

    override func viewDidLoad() {
        self.views = [
            .paragraph(text: "This button launches a file open panel for images. The chosen image will be displayed in an image view."),
            .button(text: "Open file", color: .systemBlue, didTap: { vc in
                let controller = UIDocumentPickerViewController(documentTypes: [(kUTTypeImage as String)], in: .import)
                controller.delegate = self
                vc.present(controller, animated: true, completion: nil)
            }),
            .view(view: imageView)
        ]

        super.viewDidLoad()
    }
}

extension OpenFileViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        guard let image = UIImage(contentsOfFile: url.path) else { return }
        imageView.image = image
    }
}
