//
//  SearchViewController.swift
//  ShoppingApp
//
//  Created by Jonathan Garcia on 23/05/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let kCellIdentifier = "SearchTableViewCell"
    private let kCellSize: CGFloat = 60.0
    
    @IBOutlet private weak var tableView: UITableView!
    
    let viewModel = SearchViewModel()
    let searchBar = UISearchBar() // Se crea programaticamente para poder ponerlo en el navigation Bar

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViews()
        bindViewModel()
        configSearchBar()
    }

    func configViews() {
        navigationItem.hidesBackButton = true
    }
    
    func configSearchBar() {
        searchBar.tintColor = .black
        searchBar.placeholder = Constants.kSearchBarPlaceholder
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        
        let textField = searchBar.value(forKey: "searchField") as? UITextField
        textField?.backgroundColor = .white
        
        navigationItem.titleView = searchBar
    }
    
    private func bindViewModel() {
        viewModel.products.bind { _ in
            self.tableView.reloadData()
        }
        
        viewModel.error.bind { error in
            let str = error.errorDescription ?? ""
            print(str)
            // Acá sólo imprimo el error , no se me ocurrió que tipo de error mostrar en el buscador
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as? SearchTableViewCell else {
            fatalError("Could not dequeue SearchTableViewCell")
        }
        cell.configure(product: viewModel.product(atIndex: indexPath.row))
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCellSize
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let productDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            productDetailViewController.product = viewModel.product(atIndex: indexPath.row)
            let viewControllers = self.navigationController?.viewControllers
            self.navigationController?.setViewControllers([viewControllers![0], productDetailViewController], animated: true) // Esto se hace para no pushear la pantalla actual del buscador
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getProducts(searchTerm: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.navigationController?.popViewController(animated: true)
    }
}

