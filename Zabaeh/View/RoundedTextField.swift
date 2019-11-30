//
//  RoundedTextField.swift
//  Zabaeh
//
//  Created by Awady on 11/19/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedTextField: UITextField {

    @IBInspectable var cornerRadius: CGFloat = 5.0
                                
    @IBInspectable var borderWidth: CGFloat = 2
                                
    @IBInspectable var borderColor: UIColor = UIColor.green

                                
    override func awakeFromNib() {
        self.setupView()
    }
                                
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
                                
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
    }

}
