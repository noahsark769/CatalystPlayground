//
//  ListViewController.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/1/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation
import ReactiveLists

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
}

final class ListViewController: UITableViewController {
    private var driver: TableViewDriver! = nil

    private func generateTableModel(searchText: String?) -> TableViewModel {
        return TableViewModel(sectionModels: [
            TableSectionViewModel(diffingKey: "section", cellViewModels: [
                CellViewModel(title: "Keyboard shortcuts", action: {
                    print("Something")
                }),
                CellViewModel(title: "Windows", action: {
                    print("Something")
                })
            ])
        ])
    }

    init() {
        super.init(style: .insetGrouped)
        self.title = "Examples"
        self.definesPresentationContext = true
        self.tableView.separatorStyle = .none

        driver = TableViewDriver(
            tableView: self.tableView,
            tableViewModel: generateTableModel(searchText: nil)
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
