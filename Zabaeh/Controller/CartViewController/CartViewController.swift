//
//  CartViewController.swift
//  Zabaeh
//
//  Created by Awady on 11/19/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var cartCollectionView: UICollectionView!
    
    var cartImages = [
        UIImage(named: "image7"),
        UIImage(named: "image8"),
        UIImage(named: "image9"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
        
        let cartNib = UINib(nibName: "CartCell", bundle: nil)
        self.cartCollectionView.register(cartNib, forCellWithReuseIdentifier: "CartCell")
        
    }
    
}

extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCell", for: indexPath) as! CartCell
        cell.imageSets = cartImages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 1 , height: 260)
    }
    
    
}
