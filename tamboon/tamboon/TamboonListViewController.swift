//
//  TamboonListViewController.swift
//  tamboon
//
//  Created by Kittisak Phetrungnapha on 5/3/2564 BE.
//

import UIKit

final class TamboonListViewController: UIViewController {
    
    private var viewModel: TamboonListViewControllerViewModelInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = TamboonListViewControllerViewModel(delegate: self)
    }
}

// MARK: - TamboonListViewControllerViewModelDelegate

extension TamboonListViewController: TamboonListViewControllerViewModelDelegate {
    
}
