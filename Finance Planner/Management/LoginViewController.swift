//
//  LoginViewController.swift
//  Finance Planner
//
//  Created by Student on 17.12.17.
//  Copyright © 2017 Valentin Witzeneder. All rights reserved.
//

import UIKit
import SmileLock

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordStackView: UIStackView!
    
    //MARK: Property
    var passwordContainerView: PasswordContainerView!
    let kPasswordDigit = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create PasswordContainerView
        passwordContainerView = PasswordContainerView.create(in: passwordStackView, digit: kPasswordDigit)
        passwordContainerView.delegate = self
        passwordContainerView.deleteButtonLocalizedTitle = NSLocalizedString("delete", comment: "deleteButton")
        
        //customize password UI
        passwordContainerView.tintColor = UIColor.darkGray
        passwordContainerView.highlightedColor = UIColor.lightGray
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "resetPinBackground"), object: nil, queue: nil) { (notification) in
            self.passwordContainerView.clearInput()
        }
    }
    
    //At first start tell the user to make a password
    override func viewDidAppear(_ animated: Bool) {
        if(UserDefaults.standard.object(forKey: "password") == nil){
            print("Test")
            let alert = UIAlertController(title: "Welcome", message: "Please enter a Passwort for your Finance Planner", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
}

extension LoginViewController: PasswordInputCompleteProtocol {
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        if validation(input) {
            validationSuccess()
        } else {
            validationFail()
        }
    }
    
    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {
        if success {
            self.validationSuccess()
        } else {
            passwordContainerView.clearInput()
        }
    }
}

private extension LoginViewController {
    func validation(_ input: String) -> Bool {
        let defaults = UserDefaults.standard
        if let password = defaults.object(forKey: "password") as? String {
            return input == password
        } else {
            defaults.set(input, forKey: "password")
            defaults.synchronize()
            return true
        }
    }
    
    func validationSuccess() {
        performSegue(withIdentifier: "loginSuccess", sender: self)
    }
    
    func validationFail() {
        passwordContainerView.wrongPassword()
    }
    
}

