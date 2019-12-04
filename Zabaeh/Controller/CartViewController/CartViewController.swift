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
    @IBOutlet weak var totalLabel: UILabel!
    
    
    var cartData = [CartModel]()
    let userID = Helper.getAuthToken()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configData()
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
        
        let cartNib = UINib(nibName: "CartCell", bundle: nil)
        self.cartCollectionView.register(cartNib, forCellWithReuseIdentifier: "CartCell")
    }
    func configData() {
        CartAPI.instance.cartData(userID: self.userID!) { (Success) in
            if Success {
                print("you are in Cart page")
                self.cartData = CartAPI.instance.cartData
                self.cartCollectionView.reloadData()
                
            }else {
                    print("error in Cart page")
            }
        }
    }
}

extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCell", for: indexPath) as! CartCell
        cell.configCell(cartData: cartData[indexPath.row])
        cell.stepper.maximumValue = Double(cartData[indexPath.row].maxCount!)!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 1 , height: 260)
    }
    
    
}
