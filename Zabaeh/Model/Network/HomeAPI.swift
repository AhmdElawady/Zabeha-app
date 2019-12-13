//
//  HomePageAPI.swift
//  Zabaeh
//
//  Created by Awady on 11/28/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HomeAPI {

    static let instance = HomeAPI()
    var sliderData = [SliderModel]()
    var homeData = [HomeModel]()

    func FetchHomeData(completion: @escaping (_ Success: Bool)-> ()) {
        let url = URLS.homeURL
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
                
            case .failure(let error):
                debugPrint(error)
                
            case .success(let value):
                print(value)
                
                // parseing Slider data
                let json = JSON(value)
                guard let sliderArray = json["slider"].array else {
                    completion(false)
                    return
                }
                for item in sliderArray {
                    guard let item = item.dictionary else {
                        completion(false)
                        return
                    }
                    var model = SliderModel()
                    model.id = item["id"]?.string
                    model.image = item["img"]?.string
                    model.numberOfProduct = item["num_product"]?.string
                    model.price = item["price"]?.string
                    model.textOfImage = item["text_of_img"]?.string
                    self.sliderData.append(model)
                }
                
                // parsing home data
                guard let homeArray = json["home"].array else {
                        completion(false)
                        return
                    }
                for item in homeArray {
                    var model = HomeModel()
                    model.id = item["id"].stringValue
                    model.image = item["img"].stringValue
                    self.homeData.append(model)
                }
            
            completion(true)
            }
        }
    }
}
