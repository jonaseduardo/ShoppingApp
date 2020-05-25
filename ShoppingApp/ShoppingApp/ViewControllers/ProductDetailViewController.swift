//
//  ProductDetailViewController.swift
//  ShoppingApp
//
//  Created by Jonathan Garcia on 23/05/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import UIKit

final class ProductDetailViewController: UIViewController {
    
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var conditionLabel: UILabel!
    @IBOutlet private weak var soldQuantityLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    var product: ProductViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        configure()
    }
    
    func configure() {
        
        if let condition = product?.condition, !condition.isEmpty {
            conditionLabel.text = condition
        } else {
            conditionLabel.isHidden = true
        }
        
        if let soldQuantity = product?.soldQuantity, !soldQuantity.isEmpty {
            soldQuantityLabel.text = soldQuantity
        } else {
            soldQuantityLabel.isHidden = true
        }
            
        if let title = product?.title, !title.isEmpty {
            nameLabel.text = title
        } else {
            nameLabel.isHidden = true
        }
        
        if let price = product?.price, !price.isEmpty {
            priceLabel.text = price
        } else {
            priceLabel.isHidden = true
        }
        
        product?.loadImage()
    }
    
    func bindViewModel() {
        product?.productImage.bind { image in
            self.productImage.image = image
        }
    }
    
}
