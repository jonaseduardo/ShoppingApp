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
    
    private let baseUrl = "https://api.mercadolibre.com/sites/MLA/"
    typealias ProductsCompletionHandler = ([Product]?, ApiServiceError?) -> Void
    
    func getProducts(searchTerm: String, completion: @escaping ProductsCompletionHandler) {
        let url = baseUrl + "search"
        let parameters: [String : Any] = [
            "q" : searchTerm,
            "limit" : "20" // Lo límite a 20 por poner una cantidad
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
                let localizedError = ApiServiceError.makeError(error: error)
                completion(nil, localizedError)
            }
        }
    }
}

enum ApiServiceError: LocalizedError {
    case serverError, notConnectedToInternet
    
    static func makeError(error: AFError) -> ApiServiceError {
        if let underlyingError = error.underlyingError {
             if let urlError = underlyingError as? URLError {
                 switch urlError.code {
                 case .notConnectedToInternet:
                    return .notConnectedToInternet
                 default:
                    return .serverError
                }
             }
         }
        
        return .serverError
    }

    public var errorDescription: String? {
        switch self {
        case .serverError:
            return "Ha ocurrido un error, por favor intente mas tarde"
        case .notConnectedToInternet:
            return "Por favor revise su conexión a internet"
        }
    }
}

extension ApiServiceError {
    init() {
        self = .serverError
    }
}
