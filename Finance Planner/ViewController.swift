//
//  ViewController.swift
//  Finance Planner
//
//  Created by Valentin Witzeneder on 06.12.17.
//  Copyright © 2017 Valentin Witzeneder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var pinLabel: UILabel!
    
    @IBOutlet weak var Button0: UIButton!
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var Button5: UIButton!
    @IBOutlet weak var Button6: UIButton!
    @IBOutlet weak var Button7: UIButton!
    @IBOutlet weak var Button8: UIButton!
    @IBOutlet weak var Button9: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    
    @IBAction func Button1Touch(_ sender: Any) {
        pinLabel.text! += "1"
    }
    
    @IBAction func Button2Touch(_ sender: Any) {
        pinLabel.text! += "2"
    }
    
    @IBAction func Button3Touch(_ sender: Any) {
        pinLabel.text! += "3"
    }
    
    @IBAction func Button4Touch(_ sender: Any) {
        pinLabel.text! += "4"
    }
    
    @IBAction func Button5Touch(_ sender: Any) {
        pinLabel.text! += "5"
    }
    
    @IBAction func Button6Touch(_ sender: Any) {
        pinLabel.text! += "6"
    }
    
    @IBAction func Button7Touch(_ sender: Any) {
        pinLabel.text! += "7"
    }
    
    @IBAction func Button8Touch(_ sender: Any) {
        pinLabel.text! += "8"
    }
    
    @IBAction func Button9Touch(_ sender: Any) {
        pinLabel.text! += "9"
    }
    
    @IBAction func Button0Touch(_ sender: Any) {
        pinLabel.text! += "0"
    }
    
    @IBAction func ButtonDelete(_ sender: Any) {
        if !pinLabel.text!.isEmpty {
            pinLabel.text!.removeLast()
        }
    }
    
    @IBAction func submitButton(_ sender: Any) {
        let pinCode = pinLabel.text
        if(pinCode == nil || pinCode!.count < 4) {
            let alert = UIAlertController(title: "ERROR", message: "Password has to be at least 4 numbers", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            pinLabel.text = ""
        } else {
            let pinCodeInt:Int? = Int(pinCode!)
            
            let defaults = UserDefaults.standard
            if let password = defaults.object(forKey: "password") as? Int {
                if(password == pinCodeInt){
                    self.performSegue(withIdentifier: "showPlanner", sender: self)
                }
                else{
                    let alert = UIAlertController(title: "ERROR", message: "Invalid password", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    pinLabel.text = ""
                }
            } else {
                if(!(pinCode == nil || pinCode!.count < 4)) {
                defaults.set(pinCodeInt, forKey: "password")
                defaults.synchronize()
                self.performSegue(withIdentifier: "showPlanner", sender: self)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundButtons()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "resetPinBackground"), object: nil, queue: nil) { (notification) in
            self.pinLabel.text = ""
        }
    }
    
    
    //At first start tell the user to make a password
    override func viewDidAppear(_ animated: Bool) {
        if(UserDefaults.standard.object(forKey: "password") == nil){
            print("Test")
            let alert = UIAlertController(title: "Safety", message: "Welcome to Finance Planner enter a at least 4 digit password for your Finance Manager", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //roundButtons modifies the Buttons so they appear smoother
    func roundButtons(){
        Button0.layer.cornerRadius = 10
        Button1.layer.cornerRadius = 10
        Button2.layer.cornerRadius = 10
        Button3.layer.cornerRadius = 10
        Button4.layer.cornerRadius = 10
        Button5.layer.cornerRadius = 10
        Button6.layer.cornerRadius = 10
        Button7.layer.cornerRadius = 10
        Button8.layer.cornerRadius = 10
        Button9.layer.cornerRadius = 10
        submitButton.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //test
}

