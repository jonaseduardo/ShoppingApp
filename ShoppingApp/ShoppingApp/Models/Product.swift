//
//  Product.swift
//  ShoppingApp
//
//  Created by Jonathan Garcia on 23/05/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

struct Product: Codable {
    var id: String?
    var title: String?
    var price: Double?
    var condition: String?
    var soldQuantity: Int?
    var thumbnail: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, price, condition, thumbnail
        case soldQuantity = "sold_quantity"
    }
}

struct Products: Codable {
    var products: [Product]?
    
    private enum CodingKeys: String, CodingKey {
        case products = "results"
    }
}
