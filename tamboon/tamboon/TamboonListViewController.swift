//
//  TamboonListViewController.swift
//  tamboon
//
//  Created by Kittisak Phetrungnapha on 5/3/2564 BE.
//

import UIKit
import Nuke
import OmiseSDK

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
    
    func didFinishDonate(result: Bool) {
        let message: String
        if result {
            message = "Donate success"
        } else {
            message = "Donate fail, please try again"
        }
        
        let alert = buildInformationAlertView(from: message)
        present(alert, animated: true)
        viewModel.amountTxt = nil
    }
    
    func didGetCharities() {
        tableView.reloadData()
    }
    
    func didGetError(message: String) {
        let alert = buildInformationAlertView(from: message)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: "Please input amount you want to donate", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.keyboardType = .decimalPad
            textField.placeholder = "Amount in Baht"
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { [unowned self] _ in
            self.viewModel.amountTxt = nil
        }
        
        let confirmButton = UIAlertAction(title: "Confirm", style: .default) { [unowned self] _ in
            let textField = alert.textFields![0] as UITextField
            self.viewModel.amountTxt = textField.text
            
            let creditCardView = CreditCardFormViewController.makeCreditCardFormViewController(withPublicKey: "pkey_test_5n2f9889lm32dhpumwe")
            creditCardView.delegate = self
            creditCardView.handleErrors = true
            self.present(creditCardView, animated: true)
        }
        alert.addAction(cancelButton)
        alert.addAction(confirmButton)
        
        present(alert, animated: true)
    }
}

// MARK: - CreditCardFormViewControllerDelegate

extension TamboonListViewController: CreditCardFormViewControllerDelegate {
    
    func creditCardFormViewController(_ controller: CreditCardFormViewController, didSucceedWithToken token: Token) {
        dismiss(animated: true)
        viewModel.donate(from: token)
    }
    
    func creditCardFormViewController(_ controller: CreditCardFormViewController, didFailWithError error: Error) {
        dismiss(animated: true)
        viewModel.amountTxt = nil
        let alert = buildInformationAlertView(from: error.localizedDescription)
        present(alert, animated: true)
    }
    
    func creditCardFormViewControllerDidCancel(_ controller: CreditCardFormViewController) {
        viewModel.amountTxt = nil
    }
}

private extension TamboonListViewController {
    
    func buildInformationAlertView(from message: String) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        return alert
    }
}
