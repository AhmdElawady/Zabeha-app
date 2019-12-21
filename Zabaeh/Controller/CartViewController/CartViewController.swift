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
    
    var totalAmount: Int = 0 {
        didSet {
         totalLabel.text = String(totalAmount)
        }
    }
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
        CartAPI.instance.FetchcartData(userID: self.userID!) { (Success) in
            if Success {
                print("you are in Cart page")
                self.cartData = CartAPI.instance.cartData
                self.cartCollectionView.reloadData()
                self.setTotalValue()
                
            }else {
                    print("error in Cart page")
            }
        }
    }
    
    private func setTotalValue() {
        let prices = cartData.compactMap() { data in
            (data.price ?? 0) * data.amount
        }
        let total = prices.reduce(0) { total, price in
            total + price }
        self.totalAmount = total
    }
    
    var orderID = [String: Int]()
    var countOfProduct: String?
    
    @IBAction func orderPressed(_ sender: Any) {
        
        for (index, idNumber) in self.cartData.enumerated() {
            orderID["id_product[\(index)]"] =  idNumber.id!
            orderID["count_of_product[\(index)]"] = idNumber.amount
        }
        orderID["id_user"] = userID
        orderID["total"] = Int(totalLabel.text!)
        
        CartAPI.instance.sendOrderData(OrderParameters: orderID) { (Success) in
            if Success {
                print("Order posted successfuly")
            }else {
                print("Error order not sent")
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
        cell.configCell(cartData: cartData[indexPath.row], at: indexPath.row)
        cell.stepper.maximumValue = Double(cartData[indexPath.row].maxCount!)!
        cell.stepperCounter.text = self.countOfProduct
        cell.delegate = self
        
        cell.layer.cornerRadius = 5
        cell.layer.shadowRadius = 5
        cell.layer.shadowColor = #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1)
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 1 , height: 260)
    }
}

protocol CartViewCellDelegate {
    func onAmountChange(newAmount: Int, at row: Int)
}

extension CartViewController: CartViewCellDelegate {
    func onAmountChange(newAmount: Int, at row: Int) {
        CartAPI.instance.updateItemsCountAt(index: row, value: newAmount)
        cartData = CartAPI.instance.cartData
        setTotalValue()
    }
}





