//
//  ProductCell.swift
//  Zabaeh
//
//  Created by Awady on 11/19/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configCell(productData: ProductModel) {
        mainView.layer.cornerRadius = 10
        self.priceLabel.text = productData.price! + " RS"
        self.productNameLabel.text = productData.textOfImage
        if let image = productData.image {
            productImage.kf.indicatorType = .activity
            self.productImage.kf.setImage(with: URL(string: image))
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
