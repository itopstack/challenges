//
//  TamboonListViewControllerViewModel.swift
//  tamboon
//
//  Created by Kittisak Phetrungnapha on 5/3/2564 BE.
//

import Foundation

protocol TamboonListViewControllerViewModelDelegate: AnyObject {
    func didGetCharities()
    func didGetError(message: String)
}

protocol TamboonListViewControllerViewModelInterface: AnyObject {
    func fetchCharities()
    func numberOfRows(in section: Int) -> Int
    func charity(at indexPath: IndexPath) -> Charity
}

final class TamboonListViewControllerViewModel: TamboonListViewControllerViewModelInterface {
    
    private weak var delegate: TamboonListViewControllerViewModelDelegate?
    private let session: URLSession
    
    private var charities: [Charity] = []
    
    init(delegate: TamboonListViewControllerViewModelDelegate,
         session: URLSession = URLSession.shared) {
        self.delegate = delegate
        self.session = session
    }
    
    func fetchCharities() {
        guard let url = URL(string: "http://localhost:8080/charities") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let error = error {
                    self.delegate?.didGetError(message: error.localizedDescription)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    self.delegate?.didGetError(message: "Status code is not 2xx")
                    return
                }
                
                guard let data = data else {
                    self.delegate?.didGetError(message: "The data is missing")
                    return
                }
                
                do {
                    self.charities = try JSONDecoder().decode([Charity].self, from: data)
                    self.delegate?.didGetCharities()
                } catch {
                    self.delegate?.didGetError(message: error.localizedDescription)
                }
            }
            
        }.resume()
    }
    
    func numberOfRows(in section: Int) -> Int {
        charities.count
    }
    
    func charity(at indexPath: IndexPath) -> Charity {
        charities[indexPath.row]
    }
}
