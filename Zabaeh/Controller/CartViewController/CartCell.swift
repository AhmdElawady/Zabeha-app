//
//  CartViewCellCollectionViewCell.swift
//  Zabaeh
//
//  Created by Awady on 11/19/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class CartCell: UICollectionViewCell {

    
    @IBOutlet weak var cartImageCell: UIImageView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperCounter: UILabel!
    
    var imageSets: UIImage! {
        didSet {
            cartImageCell.image = imageSets
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    @IBAction func stepperPressed(_ sender: Any) {
        stepperCounter.text = String(Int(stepper.value))
    }
}
