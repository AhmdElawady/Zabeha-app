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
    
    var productData = [ProductModel]()
//    var productImages = [
//        UIImage(named: "image1"),
//        UIImage(named: "image2"),
//        UIImage(named: "image3"),
//        UIImage(named: "image4"),
//        UIImage(named: "image5"),
//        UIImage(named: "image6"),
//        UIImage(named: "image7"),
//        UIImage(named: "image8"),
//        UIImage(named: "image9"),
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTableView.delegate = self
        productTableView.dataSource = self
        
        let productNib = UINib(nibName: "ProductCell", bundle: nil)
        productTableView.register(productNib, forCellReuseIdentifier: "ProductCell")

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
}
