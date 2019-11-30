//
//  HomeCollectionCell.swift
//  Zabaeh
//
//  Created by Awady on 11/18/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit
import Kingfisher

class HomeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var backViewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(homeData: HomeModel) {
        if let image = homeData.image {
            imageCell.kf.indicatorType = .activity
            self.imageCell.kf.setImage(with: URL(string: image))
        }
    }
    
}
