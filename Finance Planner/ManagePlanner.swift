//
//  ManagePlanner.swift
//  Finance Planner
//
//  Created by Valentin Witzeneder on 07.12.17.
//  Copyright © 2017 Valentin Witzeneder. All rights reserved.
//

import UIKit

class ManagePlanner: UIViewController {
    
    @IBOutlet weak var incomesButton: UIButton!
    @IBOutlet weak var outcomesButton: UIButton!
    @IBOutlet weak var statisticButton: UIButton!
    @IBOutlet weak var singleMonthButton: UIButton!
    @IBOutlet weak var percentageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func roundButtons() {
        incomesButton.layer.cornerRadius = 20
        outcomesButton.layer.cornerRadius = 20
        statisticButton.layer.cornerRadius = 20
        singleMonthButton.layer.cornerRadius = 20
        percentageButton.layer.cornerRadius = 20
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
