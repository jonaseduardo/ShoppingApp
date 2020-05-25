//
//  Product.swift
//  ShoppingApp
//
//  Created by Jonathan Garcia on 23/05/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import SwiftyJSON

final class Product {
    
    var id: String
    var title: String
    var price: Int
    var condition: String
    var soldQuantity: Int
    var thumbnail: String
    
    // El parseo lo hice a mano porque solo iba a necesitar pocos campos 
    init(_ dictionary: JSON) {
        id = dictionary["id"].string ?? ""
        title = dictionary["title"].string ?? ""
        price = dictionary["price"].int ?? 0
        condition = dictionary["condition"].string ?? ""
        soldQuantity = dictionary["sold_quantity"].int ?? 0
        thumbnail = dictionary["thumbnail"].string ?? ""
    }
}
