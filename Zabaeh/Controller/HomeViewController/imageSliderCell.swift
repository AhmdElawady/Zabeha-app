//
//  imageSliderCell.swift
//  Zabaeh
//
//  Created by Awady on 11/18/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class imageSliderCell: UICollectionViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configCell(sliderData: SliderModel) {
        titleLabel.text = sliderData.textOfImage
        if let image = sliderData.image {
            imageCell.kf.indicatorType = .activity
            self.imageCell.kf.setImage(with: URL(string: image))
        }
    }

}
