//
//  ProductModel.swift
//  Zabaeh
//
//  Created by Awady on 11/30/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation
import UIKit

struct ProductModel {
    
    var id: String?
    var image: String?
    var textOfImage: String?
    var price: String?
    var maxCount: String?
    var category: String?
}

struct CartModel {
    
    var id: Int?
    var image: String?
    var textOfImage: String?
    var price: String?
    var maxCount: String?
    var category: String?
    var created_at: String?
    var updated_at: String?
}
