//
//  SearchViewModel.swift
//  ShoppingApp
//
//  Created by Jonathan Garcia on 23/05/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

protocol SearchViewModelProtocol {
    var products: Box<[ProductViewModelProtocol]> { get set }
    var error: Box<ApiServiceError> { get set }
    var productsCount: Int { get }
    func getProducts(searchTerm: String)
    
    func product(atIndex index: Int) -> ProductViewModelProtocol
}

final class SearchViewModel : SearchViewModelProtocol {
    
    var products = Box([ProductViewModelProtocol]()) // Para hacer el binding se utiliza una clase Boxing
    var error: Box = Box(ApiServiceError())

    func getProducts(searchTerm: String) {
        ApiService().getProducts(searchTerm: searchTerm) { products, error in
            if let error = error {
                self.error.value = error
                return
            }
            
            var productsVm: [ProductViewModelProtocol] = []
            productsVm.append(contentsOf: products!.map({ (product) -> ProductViewModelProtocol in
                let productVm = ProductViewModel(product: product)
                return productVm
            }))
            
            self.products.value = productsVm
        }
    }
    
    var productsCount: Int {
        return products.value.count
    }

    func product(atIndex index: Int) -> ProductViewModelProtocol {
        return products.value[index]
    }

}
