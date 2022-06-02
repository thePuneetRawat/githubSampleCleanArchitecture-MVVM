//
//  TableViewController.swift
//  GithubPracticeApp
//
//  Created by Puneet Rawat on 08/05/22.
//

import UIKit

class PRListTableViewController: UITableViewController {
    
    var viewModel: PRListViewModel!
    var imageLoadManager: ImageRequestFetchManager!

    var loadingSpinner: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    
    func updateLoading(loading: Bool) {
        if loading {
            loadingSpinner?.removeFromSuperview()
            loadingSpinner = makeActivityIndicator(size: .init(width: tableView.frame.width, height: 44))
            tableView.tableFooterView = loadingSpinner
        } else {
            tableView.tableFooterView = nil
        }
    }
    
    // MARK: - Private

    private func setupViews() {
        tableView.estimatedRowHeight = PRTableViewCell.height
        tableView.rowHeight = UITableView.automaticDimension
    }

}

// MARK: - Table view data source

extension PRListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PRTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? PRTableViewCell else {
            assertionFailure("Cannot dequeue reusable cell \(PRTableViewCell.self) with reuseIdentifier: \(PRTableViewCell.reuseIdentifier)")
            return UITableViewCell()
        }
        cell.setupCell(with: viewModel.items.value[indexPath.row], imageFetchManager: imageLoadManager)

        return cell
    }
}
