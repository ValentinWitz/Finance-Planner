//
//  IncomesChart.swift
//  Finance Planner
//
//  Created by Valentin Witzeneder on 10.12.17.
//  Copyright © 2017 Valentin Witzeneder. All rights reserved.
//

import UIKit
import CoreData
import Charts


class IncomesChart: UIViewController {
    
    struct DateStruct {
        var day: Int
        var month: Int
        var year: Int
    }
    
    struct EntryStruct {
        var date: DateStruct
        var use: String
        var amount: Double
        var income: Incomes
    }
    
    struct SectionStruct {
        var month: Int
        var year: Int
        var entries = [EntryStruct]()
    }
    
    var Sections = [SectionStruct]()
    let months = ["January", "February", "March", "April", "May", "Juny", "July", "August", "September", "October", "November", "December"]
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
