//
//  SearchViewModel.swift
//  ShoppingApp
//
//  Created by Jonathan Garcia on 23/05/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

final class SearchViewModel {
    
    var products = Bindable([ProductViewModel]()) // Para hacer el binding se utiliza una clase Boxing
    var error: Bindable = Bindable(ApiServiceError())

    func getProducts(searchTerm: String) {
        ApiService().getProducts(searchTerm: searchTerm) { products, error in
            if let error = error {
                self.error.value = error
                return
            }
            
            var productsVm: [ProductViewModel] = []
            productsVm.append(contentsOf: products!.map({ (product) -> ProductViewModel in
                let productVm = ProductViewModel(product: product)
                return productVm
            }))
            
            self.products.value = productsVm
        }
    }
    
    var productsCount: Int {
        return products.value.count
    }

    func product(atIndex index: Int) -> ProductViewModel {
        return products.value[index]
    }

}
