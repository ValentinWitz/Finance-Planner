//
//  NewIncome.swift
//  Finance Planner
//
//  Created by Valentin Witzeneder on 08.12.17.
//  Copyright © 2017 Valentin Witzeneder. All rights reserved.
//

import UIKit
import CoreData

class NewIncome: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var eurosTextfield: UITextField!
    @IBOutlet weak var centsTextfield: UITextField!
    @IBOutlet weak var useText: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        eurosTextfield.keyboardType = .numberPad
        centsTextfield.keyboardType = .numberPad
        centsTextfield.text = "00"
        self.useText.delegate = self

        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        useText.layer.borderWidth = 3
        useText.layer.borderColor = borderColor.cgColor
        useText.layer.cornerRadius = 5.0
        
        datePicker.datePickerMode = .date
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
   
    

    @IBAction func doneButton(_ sender: Any) {
        if(eurosTextfield.text != "" && centsTextfield.text != "" && useText.text != "") {
            let cents = Double(centsTextfield.text!)!/100
            let euros = Double(eurosTextfield.text!)!
            let amount = euros + cents
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "Incomes", in: context)
            
            let newIncome = NSManagedObject(entity: entity!, insertInto: context)
            
            newIncome.setValue(useText.text!, forKey: "use")
            newIncome.setValue(amount, forKey: "amount")
            newIncome.setValue(datePicker.date, forKey: "date")
            
            do {
                try context.save()
                navigationController?.popViewController(animated: true)
            } catch {
                print("Failed to save to the bucketlist!")
            }
        }
            
        else {
            let alert = UIAlertController(title: "ERROR", message: "Insert the amount correctly - every Textfield has to be filled!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            }
        }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (range.length + range.location > centsTextfield.text!.count) {
            return false;
        }
        let NewLength = centsTextfield.text!.count + string.count - range.length
        
        return NewLength < 3
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
