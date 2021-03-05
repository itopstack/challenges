//
//  TamboonListViewController.swift
//  tamboon
//
//  Created by Kittisak Phetrungnapha on 5/3/2564 BE.
//

import UIKit

final class TamboonListViewController: UIViewController {
    
    private var tableView = UITableView()
    
    private var viewModel: TamboonListViewControllerViewModelInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Tamboon"
        
        viewModel = TamboonListViewControllerViewModel(delegate: self)
        
        // Setup tableview
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        let safeArea = view.safeAreaLayoutGuide
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
}

// MARK: - TamboonListViewControllerViewModelDelegate

extension TamboonListViewController: TamboonListViewControllerViewModelDelegate {
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension TamboonListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
