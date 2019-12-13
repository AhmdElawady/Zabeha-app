//
//  ViewController.swift
//  Zabaeh
//
//  Created by Awady on 11/18/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var backgroundView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCloseTouch()
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
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

        AuthAPI.signin(email: email, password: password) { (Success) in
            if Success {
                print("Your logged in successfully")
                let view = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarController") as! HomeTabBarController
                self.present(view, animated: true, completion: nil)
                
            }else {
                return
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupCloseTouch() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(SigninViewController.closetab(_:)))
        backgroundView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closetab(_ recognizer: UITapGestureRecognizer) {
    view.endEditing(true)
    }
    
    
    
    
    @IBAction func forgetPasswordPressed(_ sender: Any) {
    }
    
}

