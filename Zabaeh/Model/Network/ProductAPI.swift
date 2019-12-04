//
//  ProductAPI.swift
//  Zabaeh
//
//  Created by Awady on 11/28/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProductAPI {
    
    static let instance = ProductAPI()
    var categoryData = [ProductModel]()
    
    func categoryData( id: String, completion: @escaping (_ Success: Bool)-> ()) {
        let url = URLS.categoryURL
        
        let parameter: [String: Any] = ["id_product": id]
    
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
                case .failure(let error):
                    debugPrint(error)
            
                case .success(let value):
                    print(value)
                let json = JSON(value)
                guard let productArray = json["product"].array else {
                    completion(false)
                    return
                }
                for item in productArray {
                    guard let item = item.dictionary else {
                        completion(false)
                        return
                    }
                    var model = ProductModel()
                    model.id = item["id"]?.string
                    model.image = item["img"]?.string
                    model.category = item["category"]?.string
                    model.price = item["price"]?.string
                    model.textOfImage = item["text_of_img"]?.string
                    model.maxCount = item["max_count"]?.string
                    self.categoryData.append(model)
                }
                    
            completion(true)
                
            }
        }
    }
    
    func productData( id: String, userID: Int, completion: @escaping (_ Success: Bool)-> ()) {
        let url = URLS.productURL
        
        let parameter: [String: Any] = ["id_product": id, "id_user": userID]
    
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
                case .failure(let error):
                    completion(false)
                    debugPrint(error)
            
                case .success(let value):
                    print(value)
                    completion(true)
            }
        }
    }
}
