//
//  String+Extenison.swift
//  Zabaeh
//
//  Created by Awady on 11/23/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation

extension String {
    var isValideEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        
        return emailPredicate.evaluate(with: self)
    }
}
