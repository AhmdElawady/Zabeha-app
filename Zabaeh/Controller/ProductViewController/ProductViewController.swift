//
//  productViewController.swift
//  Zabaeh
//
//  Created by Awady on 11/19/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var productTableView: UITableView!
    var productId: String = ""
    var categoryID: String = ""
    var productData = [ProductModel]()
    let userID = Helper.getAuthToken()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(categoryID)
        configeData()
        productTableView.delegate = self
        productTableView.dataSource = self
        
        let productNib = UINib(nibName: "ProductCell", bundle: nil)
        productTableView.register(productNib, forCellReuseIdentifier: "ProductCell")
    }
    
    func configeData() {
        ProductAPI.instance.categoryData(id: categoryID) { (Success) in
            if Success {
                print("you are in product page")
                self.productData = ProductAPI.instance.categoryData
                self.productTableView.reloadData()
            }
        }
    }
}
extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
        cell.configCell(productData: productData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alertController = UIAlertController(title: "Add To Cart?", message: "Do you want to add this item to your cart?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            ProductAPI.instance.productData(id: self.productId, userID: self.userID!) { (Success) in
                if Success {
                    self.productTableView.reloadData()
                    print("product ID \(self.productId), user ID \(String(describing: self.userID))")
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        self.productId = productData[indexPath.row].id ?? ""
    }
}
