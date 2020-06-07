//
//  ProductViewModel.swift
//  ShoppingApp
//
//  Created by Jonathan Garcia on 24/05/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import Alamofire
import AlamofireImage

protocol ProductViewModelProtocol {
    var product: Product? { get set }
    var productImage: Box<UIImage>? { get set }
    var title: String { get }
    var price: String { get }
    var condition: String { get }
    var soldQuantity: String { get }
    
    init(product: Product)
    func loadImage()
}

final class ProductViewModel: ProductViewModelProtocol {
    
    var product: Product?

    init(product: Product) {
        self.product = product
        self.productImage = Box(UIImage())
    }
    
    func loadImage() {
        guard let url = product?.thumbnail, !url.isEmpty else { return }
        
        AF.request(url).responseImage { response in
            if case .success(let image) = response.result {
                self.productImage?.value = image
            }
        }
    }
    
    var productImage: Box<UIImage>?
    
    var title: String {
        return product?.title ?? ""
    }
    
    var price: String {
        guard let price = product?.price else { return "" }
        
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .decimal
        guard let priceStr = formater.string(from: NSNumber.init(value: price)) else { return "" }
        
        return "$ " + priceStr
    }
    
    var condition: String {
        let condition = Condition(rawValue: product?.condition ?? "")
        guard let conditionName = condition?.name else { return "" }
        return conditionName + " |"
    }
    
    var soldQuantity: String {
        guard let soldQuantity = product?.soldQuantity else { return "" }
        return String(soldQuantity) + " Vendidos"
    }
}

private enum Condition: String {
    case new
    case used
    
    var name: String {
        switch self {
        case .new:
            return "Nuevo"
        case .used:
            return "Usado"
        }
    }
}
