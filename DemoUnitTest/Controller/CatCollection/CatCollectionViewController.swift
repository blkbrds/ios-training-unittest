//
//  CatCollectionViewController.swift
//  DemoUnitTest
//
//  Created by Thuy Nguyen T.H on 11/10/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import UIKit
import SwiftUtils

class CatCollectionViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    var viewModel = CatCollectionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configTableView()
        getData()
    }

    private func configTableView() {
        tableView.register(CatCell.self)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func getData() {
        viewModel.getCats { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
            case .failure(let error):
                let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let close = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertVC.addAction(close)
                this.present(alertVC, animated: true, completion: nil)
            }
        }
    }

    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CatCollectionViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CatCell.self)
        if let cellModel = try? viewModel.viewModelForItem(at: indexPath) {
            cell.viewModel = cellModel
        }
        return cell
    }
}
