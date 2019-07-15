//
//  ListViewController.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/1/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation
import ReactiveLists

enum DetailType: String, CaseIterable {
    case keyboardShortcuts = "Keyboard Shortcuts"
    case windows = "Windows"
    case hover = "Hover"
    case dragAndDrop = "Drag and drop"
}

struct CellViewModel: TableCellViewModel {
    var accessibilityFormat: CellAccessibilityFormat {
        return CellAccessibilityFormat(self.title)
    }

    func applyViewModelToCell(_ cell: UITableViewCell) {
        cell.textLabel?.text = self.title
    }

    var registrationInfo = ViewRegistrationInfo(classType: UITableViewCell.self)

    let title: String
    let action: () -> Void

    var didSelect: DidSelectClosure? {
        return {
            self.action()
        }
    }

    init(detailType: DetailType, didSelect: @escaping (DetailType) -> Void) {
        self.title = detailType.rawValue
        self.action = {
            didSelect(detailType)
        }
    }
}

final class ListViewController: UITableViewController {
    private var driver: TableViewDriver! = nil

    private func generateTableModel(searchText: String?) -> TableViewModel {
        return TableViewModel(sectionModels: [
            TableSectionViewModel(diffingKey: "section", cellViewModels: DetailType.allCases.map { type in
                return CellViewModel(detailType: type, didSelect: self.didSelectDetailType)
            })
        ])
    }

    let didSelectDetailType: (DetailType) -> Void

    init(didSelectDetailType: @escaping (DetailType) -> Void) {
        self.didSelectDetailType = didSelectDetailType
        super.init(style: .insetGrouped)
        self.title = "Examples"

        driver = TableViewDriver(
            tableView: self.tableView,
            tableViewModel: generateTableModel(searchText: nil)
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
