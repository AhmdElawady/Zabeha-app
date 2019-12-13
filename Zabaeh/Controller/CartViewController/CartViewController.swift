//
//  CartViewController.swift
//  Zabaeh
//
//  Created by Awady on 11/19/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    var stepperCounter = 0
    var totalAmount: Int = 0 {
           didSet {
            totalLabel.text = String(totalAmount)
           }
       }


    @IBOutlet weak var cartCollectionView: UICollectionView!
    @IBOutlet weak var totalLabel: UILabel!
    
    var cartData = [CartModel]()
    let userID = Helper.getAuthToken()
    var cart = CartModel()

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
        let total =  cartData.compactMap({ $0.price }).reduce(0) { total, price in
            total + (Int(price) ?? 0) }
        self.totalAmount = total
    }
    
    var orderID = [String:Int]()
    var countOfProduct: String?
    
    @IBAction func orderPressed(_ sender: Any) {
        
        for (index, idNumber) in self.cartData.enumerated() {
            orderID = ["id_product[\(index)]": idNumber.id!]
            orderID["id_user[\(index)]"] = userID
            orderID["total"] = Int(totalLabel.text!)
            orderID["count_of_product"] = Int(countOfProduct ?? "")
            print(countOfProduct)
        }
        
        CartAPI.instance.sendOrderData(OrderID: orderID) { (Success) in
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
        cell.configCell(cartData: cartData[indexPath.row])
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
    func onAmountChange(newAmount: Int, state: stepperState)
}

public enum stepperState {
    case plus
    case minus
}

extension CartViewController: CartViewCellDelegate {
    func onAmountChange(newAmount: Int, state: stepperState) {
        if state == .minus {
            self.totalAmount -= newAmount
            self.totalLabel.text = String(totalAmount)
        } else if state == .plus {
            self.totalAmount += newAmount
            self.totalLabel.text = String(totalAmount)
        }
    }
}





