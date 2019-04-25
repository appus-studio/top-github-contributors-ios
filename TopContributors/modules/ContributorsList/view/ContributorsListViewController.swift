//
//  ContributorsListViewController.swift
//  TopContributors
//
//  Created Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import UIKit

final class ContributorsListViewController: UIViewController, ViperView {
    var viperComponents: VIPERComponents!
    weak var presenter: ContributorsListPresenterProtocol!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var troubleView: UIView!
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideTroubleView()
        self.title = R.string.localizable.topContributors()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    @IBAction func refreshAction() {
      self.presenter.refreshAction()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
}

extension ContributorsListViewController: ContributorsListViewProtocol {
    func showTroubleView() {
        self.tableView.isHidden = true
        self.troubleView.isHidden = false
    }
    func hideTroubleView() {
        self.tableView.isHidden = false
        self.troubleView.isHidden = true
    }
    func hideRefresher() {
        self.refreshControl.endRefreshing()
    }
    func reloadData() {
        self.tableView.reloadData()
    }
}

// MARK: Cell Delegate

extension ContributorsListViewController: ListCellDelegate {
    func tapedLocationButton(cell: ListCell) {
        guard let index = self.tableView.indexPath(for: cell) else {
            fatalError()
        }
        self.presenter.tapedLocationButton(index: index.row)
    }
}

// MARK: TableView Data Source

extension ContributorsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.contributorsCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.listCell, for: indexPath) else {
            fatalError()
        }
        let contributor = self.presenter.contributor(index: indexPath.row)
        cell.configure(with: self, and: contributor)
        return cell
    }
}
