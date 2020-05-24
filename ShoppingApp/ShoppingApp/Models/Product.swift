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
    var price: String
    var condition: String
    var thumbnail: String
    var addressStateName: String
    
    init(_ dictionary: JSON) {
        id = dictionary["id"].string ?? ""
        title = dictionary["title"].string ?? ""
        price = dictionary["price"].string ?? ""
        condition = dictionary["condition"].string ?? ""
        thumbnail = dictionary["thumbnail"].string ?? ""
        addressStateName = dictionary["address"]["state_name"].string ?? ""
    }
}
