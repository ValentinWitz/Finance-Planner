//
//  SingleMonthView.swift
//  Finance Planner
//
//  Created by Valentin Witzeneder on 14.12.17.
//  Copyright © 2017 Valentin Witzeneder. All rights reserved.
//

import UIKit
import CoreData
import Charts

class SingleMonthView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var monthPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    
    let months = ["January", "February", "March", "April", "May", "Juny", "July", "August", "September", "October", "November", "December"]
    var years = [Int]()
    
    var selectedMonth: Int = 0
    var selectedYear: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year =  components.year!
        
        years = [year-3,year-2,year-1,year,year+1,year+2,year+3]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == monthPicker){
            return months[row]
        }
        else{
            return years[row].description
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == monthPicker){
            return 12
        }
        else{
            return 7
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == monthPicker){
            selectedMonth = row+1
        }
        else{
            selectedYear = Int(years[row])
        }
        //setChart(month: selectedMonth, year: selectedYear)
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
