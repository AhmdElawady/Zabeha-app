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
    
    var cartStippermodel = CartModel()
    
    var oldCount = 0
    var delegate: CartViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(cartData: CartModel) {
        cartStippermodel = cartData
        priceLabel.text = cartData.price
        nameLabel.text = cartData.textOfImage
        if let image = cartData.image {
            cartImageCell.kf.indicatorType = .activity
            self.cartImageCell.kf.setImage(with: URL(string: image))
        }
    }
    
    @IBAction func stepperPressed(_ sender: Any) {
        if oldCount > Int(stepper.value) {
            delegate.onAmountChange(newAmount: Int(stepper.stepValue * Double((cartStippermodel.price)!)!), state: .minus)
        }
        else {
            delegate.onAmountChange(newAmount: Int(stepper.stepValue * Double((cartStippermodel.price)!)!), state: .plus)
        }
        
        
        stepperCounter.text = String(Int(stepper.value))
        let priceText = Int(stepper.value) * (Int(cartStippermodel.price ?? "") ?? 0)
        priceLabel.text = String(priceText)
    }
}
