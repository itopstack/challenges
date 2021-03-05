//
//  TamboonListViewController.swift
//  tamboon
//
//  Created by Kittisak Phetrungnapha on 5/3/2564 BE.
//

import UIKit
import Nuke

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let safeArea = view.safeAreaLayoutGuide
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        viewModel.fetchCharities()
    }
}

// MARK: - TamboonListViewControllerViewModelDelegate

extension TamboonListViewController: TamboonListViewControllerViewModelDelegate {
    
    func didGetCharities() {
        tableView.reloadData()
    }
    
    func didGetError(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension TamboonListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let charity = viewModel.charity(at: indexPath)
        cell.textLabel?.text = charity.name
        
        if let imageView = cell.imageView {
            Nuke.loadImage(with: charity.logoURL, into: imageView)
        }
        
        return cell
    }
}
