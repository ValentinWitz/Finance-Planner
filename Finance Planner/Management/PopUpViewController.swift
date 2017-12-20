//
//  PopUpViewController.swift
//  Finance Planner
//
//  Created by Student on 10.12.17.
//  Copyright © 2017 Valentin Witzeneder. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var PopUpView: UIView!
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var useLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PopUpView.layer.cornerRadius = 10
        buttonClose.layer.cornerRadius = 10
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        self.showAnimate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopUp(_ sender: UIButton) {
        self.removeAnimate()
        //self.view.removeFromSuperview()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
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
