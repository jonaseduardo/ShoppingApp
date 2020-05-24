//
//  HomeViewController.swift
//  ShoppingApp
//
//  Created by Jonathan Garcia on 23/05/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViews()
        configSearchBar()
    }
    
    func configViews() {
        navigationItem.title = ""
    }
    
    func configSearchBar() {
        searchBar.placeholder = Constants.kSearchBarPlaceholder
        searchBar.delegate = self
                
        let textField = searchBar.value(forKey: "searchField") as? UITextField
        textField?.backgroundColor = .white
        
        navigationItem.titleView = searchBar
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let searchViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
            self.navigationController?.pushViewController(searchViewController, animated: true)
            searchBar.resignFirstResponder()
        }
    }
}
