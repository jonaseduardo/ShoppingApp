//
//  SearchViewModel.swift
//  ShoppingApp
//
//  Created by Jonathan Garcia on 23/05/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

final class SearchViewModel {
    
    var products = Bindable([ProductViewModel]())
    //var error: Bindable = Bindable(Error.self)

    func getProducts(searchTerm: String) {
        ApiService().getProducts(searchTerm: searchTerm) { products, error in
            if let error = error {
                print(error.localizedDescription)
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
