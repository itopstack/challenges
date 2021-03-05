//
//  TamboonListViewControllerViewModel.swift
//  tamboon
//
//  Created by Kittisak Phetrungnapha on 5/3/2564 BE.
//

import Foundation

protocol TamboonListViewControllerViewModelDelegate: AnyObject {
    
}

protocol TamboonListViewControllerViewModelInterface: AnyObject {
    
}

final class TamboonListViewControllerViewModel: TamboonListViewControllerViewModelInterface {
    
    private weak var delegate: TamboonListViewControllerViewModelDelegate?
    
    init(delegate: TamboonListViewControllerViewModelDelegate) {
        self.delegate = delegate
    }
}
