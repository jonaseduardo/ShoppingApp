//
//  SearchTableViewCell.swift
//  ShoppingApp
//
//  Created by Jonathan Garcia on 23/05/2020.
//  Copyright © 2020 Jonathan Garcia. All rights reserved.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!

    func configure(product: ProductViewModel) {
        titleLabel.text = product.title
    }
}
