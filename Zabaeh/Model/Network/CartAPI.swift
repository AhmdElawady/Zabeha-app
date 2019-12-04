//
//  CartAPI.swift
//  Zabaeh
//
//  Created by Awady on 12/2/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CartAPI {
    
    static let instance = CartAPI()
    var cartData = [CartModel]()
    
    func cartData(userID: Int, completion: @escaping (_ Success: Bool)-> ()) {
        let url = URLS.cartURL
        
        let parameter: [String: Any] = ["id_user": userID]
    
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
                case .failure(let error):
                    completion(false)
                    debugPrint(error)
            
                case .success(let value):
                    print(value)
                    let json = JSON(value)
                    
                    guard let cartArray = json["Order"].array else {
                        completion(false)
                        return
                    }
                    
                    for item in cartArray {
                        guard let item = item.dictionary else {
                            completion(false)
                            return
                        }
                        var model = CartModel()
                        model.id = item["id"]?.string
                        model.image = item["img"]?.string
                        model.category = item["category"]?.string
                        model.price = item["price"]?.string
                        model.textOfImage = item["text_of_img"]?.string
                        model.maxCount = item["max_count"]?.string
                        self.cartData.append(model)
                    }
                    
                    completion(true)
            }
        }
    }
}
