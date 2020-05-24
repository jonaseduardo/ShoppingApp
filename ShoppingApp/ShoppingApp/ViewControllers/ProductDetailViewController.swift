//
//  ProductDetailViewController.swift
//  ShoppingApp
//
//  Created by Jonathan Garcia on 23/05/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import UIKit

final class ProductDetailViewController: UIViewController {
    
    @IBOutlet final weak var nameLabel: UILabel!
    @IBOutlet final weak var priceLabel: UILabel!
    
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        nameLabel.text = product?.title
        priceLabel.text = product?.condition
    }
    
}
