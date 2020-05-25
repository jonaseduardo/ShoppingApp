//
//  ApiService.swift
//  ShoppingApp
//
//  Created by Jonathan Garcia on 23/05/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import Alamofire
import SwiftyJSON

final class ApiService {
    
    let baseUrl = "https://api.mercadolibre.com/sites/MLA/"
    typealias ProductsCompletionHandler = ([Product]?, Error?) -> Void
    
    func getProducts(searchTerm: String, completion: @escaping ProductsCompletionHandler) {
        let url = baseUrl + "search"
        let parameters: [String : Any] = [
            "q" : searchTerm,
            "limit" : "20"
        ]

        AF.request(url, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let results = JSON(value)["results"]
                
                var products: [Product] = []
                products.append(contentsOf: results.map({ (result) -> Product in
                    let product = Product(result.1)
                    return product
                }))
                completion(products, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
