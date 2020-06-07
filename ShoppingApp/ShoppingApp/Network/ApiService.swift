//
//  ApiService.swift
//  ShoppingApp
//
//  Created by Jonathan Garcia on 23/05/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import Alamofire

final class ApiService {
    
    private let baseUrl = "https://api.mercadolibre.com/sites/MLA/"
    typealias ProductsCompletionHandler = ([Product]?, ApiServiceError?) -> Void
    
    func getProducts(searchTerm: String, completion: @escaping ProductsCompletionHandler) {
        let url = baseUrl + "search"
        let parameters: [String : Any] = [
            "q" : searchTerm,
            "limit" : "20" // Lo límite a 20 por poner una cantidad
        ]

        AF.request(url, parameters: parameters).validate().responseData { response in
            switch response.result {
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let result =  try decoder.decode(Products.self, from: value)
                    completion(result.products, nil)
                    dump(result)
                } catch let error {
                    print(error.localizedDescription)
                    completion([], nil)
                }
                
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

    public var errorDescription: String {
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
