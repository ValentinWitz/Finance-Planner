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


class IncomesChart: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var incomesChart: BarChartView!
    
    @IBOutlet weak var monthPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    
    var selectedMonth: Int = 0
    var selectedYear: Int = 0
    
    
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
    var years = [Int]()
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == monthPicker){
            return months[row]
        }
        else{
            let date = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            
            let year =  components.year
            let year1 = year!+1
            let year2 = year!+2
            let year3 = year!+3
            let year4 = year!-1
            let year5 = year!-2
            let year6 = year!-3
            
            
            years = [year6,year5,year4,year!,year1,year2,year3]
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
        }
    
//    func setChart(month: Int, year: Int) {
//        incomesChart.delegate = (self as! ChartViewDelegate)
//        var dataEntries: [ChartDataEntry] = []
//        var dataMonths:[String] = []
//
//        //get the Data from the month/year and display
//
//    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Sections.removeAll()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Incomes")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [Incomes] {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                
                dateFormatter.dateFormat = "dd"
                let day = Int(dateFormatter.string(from: data.date!))!
                dateFormatter.dateFormat = "MM"
                let month = Int(dateFormatter.string(from: data.date!))!
                dateFormatter.dateFormat = "yyyy"
                let year = Int(dateFormatter.string(from: data.date!))!
                let date = DateStruct(day: day, month: month, year: year)
                let use = data.use!
                let amount = data.amount
                
                if !sectionContains(month: month, year: year) {
                    Sections.append(SectionStruct(month: month, year: year, entries: [EntryStruct]()))
                }
                
                let entry = EntryStruct(date: date, use: use, amount: amount, income: data)
                let index = getIndexOfSection(month: entry.date.month, year: entry.date.year)
                Sections[index].entries.append(entry)
                
                Sections.sort{ (lhs: SectionStruct, rhs: SectionStruct) -> Bool in
                    if lhs.year != rhs.year {
                        return lhs.year < rhs.year
                    } else {
                        return lhs.month < rhs.month
                    }
                }
                
                Sections[index].entries.sort{ (lhs: EntryStruct, rhs: EntryStruct) -> Bool in
                    if lhs.date.year != rhs.date.year {
                        return lhs.date.year < rhs.date.year
                    } else {
                        if lhs.date.month != rhs.date.month {
                            return lhs.date.month < rhs.date.month
                        } else {
                            if lhs.date.day != rhs.date.day {
                                return lhs.date.day < rhs.date.day
                            } else {
                                return lhs.amount < rhs.amount
                            }
                        }
                    }
                }
                
            }
        } catch {
            print("Failed fetch")
        }

       // setChart(month: selectedMonth, year: selectedYear)
    }
    
    func sectionContains(month: Int, year: Int) -> Bool {
        for sec in Sections {
            if sec.month == month && sec.year == year {
                return true
            }
        }
        return false
    }
    
    func getIndexOfSection(month: Int, year: Int) -> Int{
        var index = 0
        for sec in Sections {
            if sec.month == month && sec.year == year {
                return index
            }
            index = index + 1
        }
        return index
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
