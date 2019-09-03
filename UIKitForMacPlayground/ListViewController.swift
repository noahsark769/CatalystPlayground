//
//  ListViewController.swift
//  UIKitForMacPlayground
//
//  Created by Noah Gilmore on 7/1/19.
//  Copyright © 2019 Noah Gilmore. All rights reserved.
//

import Foundation
import UIKit

enum Section {
    case main
}

final class ListViewController: UITableViewController {
    let didSelectDetailType: (DetailType) -> Void
    private var dataSource: UITableViewDiffableDataSource<Section, DetailType>!

    private static var reuseIdentifier = "cell"

    init(didSelectDetailType: @escaping (DetailType) -> Void) {
        self.didSelectDetailType = didSelectDetailType
        super.init(style: .plain)
        self.title = "Examples"

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.reuseIdentifier)

        dataSource = UITableViewDiffableDataSource(tableView: self.tableView) { tableView, indexPath, detailType in
            let cell = tableView.dequeueReusableCell(withIdentifier: Self.reuseIdentifier)!
            cell.textLabel?.text = detailType.rawValue
            return cell
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, DetailType>()
        snapshot.appendSections([.main])
        snapshot.appendItems(DetailType.allCases)
        dataSource.apply(snapshot)
        self.tableView.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let detailType = dataSource.itemIdentifier(for: indexPath) else { return }
        self.didSelectDetailType(detailType)
    }
}
