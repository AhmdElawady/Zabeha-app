//
//  SignupViewController.swift
//  Zabaeh
//
//  Created by Awady on 11/18/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCloseTouch()
        
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        
        guard let email = emailTextField.text, !email.isEmpty else {
            Alert.showBasic(title: "Incomplete Form", message: "Please fill out all fields", vc: self)
            return
        }
        if email.isValideEmail == false {
            Alert.showBasic(title: "Invalide Email Formate", message: "Please make sure you formate your mail correctly", vc: self)
        }
        guard let password = passwordTextField.text, !password.isEmpty, password.count >= 8 else {
            Alert.showBasic(title: "Password Too Short", message: "Password should be at least 8 characters", vc: self)
            return
        }
        guard let repassword = rePasswordTextField.text else {return}
        if password != repassword {
            Alert.showBasic(title: "Wrong Password Confirmation", message: "Password Confirmation must be equal password", vc: self)
            return
        }
        guard let username = usernameTextField.text, !username.isEmpty else {
            Alert.showBasic(title: "Incomplete Form", message: "Please fill out all fields", vc: self)
            return
        }
        guard let phone = phoneTextField.text, !phone.isEmpty else {
            Alert.showBasic(title: "Incomplete Form", message: "Please fill out all fields", vc: self)
            return
        }
        guard let address = addressTextField.text, !address.isEmpty else {
            Alert.showBasic(title: "Incomplete Form", message: "Please fill out all fields", vc: self)
            return
        }
        
        AuthAPI.register(username: username, email: email, phone: phone, Address: address, password: password) { (Success: Bool) in
            if Success == true {
                print("Registerd Successfully")
            }
        }
    }
    
    
    func setupCloseTouch() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(SigninViewController.closetab(_:)))
        backgroundView.addGestureRecognizer(closeTouch)
    }
    @objc func closetab(_ recognizer: UITapGestureRecognizer) {
    view.endEditing(true)
    }
}
