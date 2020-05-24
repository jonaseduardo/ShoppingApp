//
//  SearchViewModel.swift
//  ShoppingApp
//
//  Created by Jonathan Garcia on 23/05/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

final class SearchViewModel {
    
    var products = Bindable([Product]())

    func getProducts(searchTerm: String) {
        ApiService().getProducts(searchTerm: searchTerm) { products, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.products.value = products ?? []
        }
    }
    
    var productsCount: Int {
        return products.value.count
    }

    func product(atIndex index: Int) -> Product {
        return products.value[index]
    }

}
