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
    
    static var instance = ProductAPI()
    
    var productData = [ProductModel]()
    
    func productData( id: String, complition: @escaping (_ Success: Bool)-> ()) {
        let url = URLS.productURL
        let parameter: [String: Any] = ["id": id]
    
        Alamofire.request(url, method: .get, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
                case .failure(let error):
                    debugPrint(error)
            
                case .success(let value):
                    print(value)
            }
        }
    }
}
