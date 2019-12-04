//
//  Helper.swift
//  Zabaeh
//
//  Created by Awady on 11/24/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation

class Helper {
    
    class func saveUserID(userID: Int) {
        
        let defoult = UserDefaults.standard
        //save UserID to UserDefoult
        defoult.setValue(userID, forKey: "id")
        defoult.synchronize()
        
    }
    
    class func getAuthToken() -> Int? {
        
        let defoult = UserDefaults.standard
        return defoult.object(forKey: "id") as? Int
    }
}
