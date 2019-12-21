//
//  CartViewCellCollectionViewCell.swift
//  Zabaeh
//
//  Created by Awady on 11/19/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class CartCell: UICollectionViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cartImageCell: UIImageView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperCounter: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var cellRow = 0
    var price = 0.0
    var delegate: CartViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(cartData: CartModel, at row: Int) {
        priceLabel.text = String(cartData.price ?? 0)
        stepperCounter.text = String(cartData.amount)
        stepper.value = Double(cartData.amount)
        cellRow = row
        self.price = Double(cartData.price ?? 0)
        nameLabel.text = cartData.textOfImage
        if let image = cartData.image {
            cartImageCell.kf.indicatorType = .activity
            self.cartImageCell.kf.setImage(with: URL(string: image))
        }
    }
    
    @IBAction func stepperPressed(_ sender: Any) {
        delegate.onAmountChange(newAmount: Int(stepper.value), at: cellRow )
        stepperCounter.text = String(Int(stepper.value))
        let priceText = Int(stepper.value) * Int(price)
        priceLabel.text = String(priceText)
    }
}
