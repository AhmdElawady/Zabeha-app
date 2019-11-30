//
//  AuthAPI.swift
//  Zabaeh
//
//  Created by Awady on 11/24/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthAPI {
    
    class func signin(email: String, password: String, completion: @escaping (_ Success: Bool) -> ()) {
        
        let url = URLS.signinURL
        let parameters = [
            "name": email,
            "password": password
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                debugPrint(error)
                completion(false)
                
            case .success(let value):
                let json = JSON(value)
                print(json)
                completion(true)
            }
        }
    }
    
    class func register(username: String, email: String, phone: String, Address: String, password: String, completion: @escaping (_ Success: Bool) -> ()) {
    
        let url = URLS.registerURL
        let parameters: [String: Any] = [
            "name": username,
            "email": email,
            "phone": phone,
            "password": password,
            "confirmpassword": password,
            "long": "0",
            "lat": "0"
            ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                debugPrint(error)
                completion(false)
                
            case .success(let value):
                let json = JSON(value)
                print(json)
                completion(true)

            }
        }
    }
}


        
    //    class func productData(complition: @escaping (_ Success: Bool) -> ()) {
    //        let url = URLS.productURL
    //        var sliderData = [HomeModel]()
    //
    //        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
    //            switch response.result {
    //            case .failure(let error):
    //                debugPrint(error)
    //
    //            case .success(let value):
    //                print(value)
    //                guard let Data = response.data else {return}
    //                if let json = try! JSON(data: Data).array {
    //                    for item in json {
    //                        let id = item["id"].stringValue
    //                        let image = item["img"].stringValue
    //                        let price = item["price"].stringValue
    //                        let textOfImage = item["text_of_img"].stringValue
    //                        let maxCount = item["num_product"].stringValue
    //
    //                        let data = HomeModel(id: id, image: image, price: price, textOfImage: textOfImage, maxCount: maxCount)
    //                        sliderData.append(data)
    //                    }
    //                }
    //
    //            }
    //        }
    //    }

