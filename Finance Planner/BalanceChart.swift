//
//  BalanceChart.swift
//  Finance Planner
//
//  Created by Valentin Witzeneder on 10.12.17.
//  Copyright © 2017 Valentin Witzeneder. All rights reserved.
//

import UIKit
import CoreData
import Charts

class BalanceChart: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var balanceChart: BarChartView!
    @IBOutlet weak var monthPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    
   
    var selectedMonth: Int = 0
    var selectedYear: Int = 0
    
    
    struct DateStruct {
        var day: Int
        var month: Int
        var year: Int
    }
    
    struct EntryStructOutcome {
        var date: DateStruct
        var use: String
        var amount: Double
        var outcome: Outcomes
    }
    
    struct SectionStructOutcome {
        var month: Int
        var year: Int
        var entries = [EntryStructOutcome]()
    }
    
    struct EntryStructIncome {
        var date: DateStruct
        var use: String
        var amount: Double
        var income: Incomes
    }
    
    struct SectionStructIncome {
        var month: Int
        var year: Int
        var entries = [EntryStructIncome]()
    }
    
    
    var Outcomes = [SectionStructOutcome]()
    var Incomes = [SectionStructIncome]()
    
    let months = [NSLocalizedString("JanuaryCharts", comment: "month"),
                  NSLocalizedString("FebruaryCharts", comment: "month"),
                  NSLocalizedString("MarchCharts", comment: "month"),
                  NSLocalizedString("AprilCharts", comment: "month"),
                  NSLocalizedString("MayCharts", comment: "month"),
                  NSLocalizedString("JunyCharts", comment: "month"),
                  NSLocalizedString("JulyCharts", comment: "month"),
                  NSLocalizedString("AugustCharts", comment: "month"),
                  NSLocalizedString("SeptemberCharts", comment: "month"),
                  NSLocalizedString("OctoberCharts", comment: "month"),
                  NSLocalizedString("NovemberCharts", comment: "month"),
                  NSLocalizedString("DecemberCharts", comment: "month")]
    var years = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year =  components.year!
        let month = components.month!
        
        selectedYear = year
        selectedMonth = month
        
        years = [year-3,year-2,year-1,year,year+1,year+2,year+3]
        
        monthPicker.selectRow(month-1, inComponent: 0, animated: false)
        yearPicker.selectRow(year - 2014, inComponent: 0, animated: false)
        
        Outcomes.removeAll()
        Incomes.removeAll()
        getDataIncomes()
        getDataOutcomes()
        
        setChart(month: month, year: year)
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
        setChart(month: selectedMonth, year: selectedYear)
    }
    
    func setChart(month: Int, year: Int) {
        
        var dataEntries: [ChartDataEntry] = []
        
        var year_minus2: Int
        var month_minus2 = month-2
        if(month_minus2 < 1){
            month_minus2 += 12
            year_minus2 = year-1
        }
        else{
            year_minus2 = year
        }
        
        var year_minus1: Int
        var month_minus1 = month-1
        if(month_minus1 < 1){
            month_minus1 += 12
            year_minus1 = year-1
        }
        else{
            year_minus1 = year
        }
        
        var year_plus1: Int
        var month_plus1 = month+1
        if(month_plus1 > 12){
            month_plus1 -= 12
            year_plus1 = year+1
        }
        else{
            year_plus1 = year
        }
        
        var year_plus2: Int
        var month_plus2 = month+2
        if(month_plus2 > 12){
            month_plus2 -= 12
            year_plus2 = year+1
        }
        else{
            year_plus2 = year
        }
        
        var data: Double = 0
        let currMonth = months[month-1]
        for section in Incomes {
            if (section.year == year && section.month == month) {
                for entry in section.entries {
                    data += entry.amount
                }
            }
        }
        for section in Outcomes {
            if (section.year == year && section.month == month) {
                for entry in section.entries {
                    data -= entry.amount
                }
            }
        }
        
        
        
        var data_m1: Double = 0
        let currMonth_m1 = months[month_minus1-1]
        for section in Incomes {
            if (section.year == year_minus1 && section.month == month_minus1) {
                for entry in section.entries {
                    data_m1 += entry.amount
                }
            }
        }
        for section in Outcomes {
            if (section.year == year_minus1 && section.month == month_minus1) {
                for entry in section.entries {
                    data_m1 -= entry.amount
                }
            }
        }
        
        var data_m2: Double = 0
        let currMonth_m2 = months[month_minus2-1]
        for section in Incomes {
            if (section.year == year_minus2 && section.month == month_minus2) {
                for entry in section.entries {
                    data_m2 += entry.amount
                }
            }
        }
        for section in Outcomes {
            if (section.year == year_minus2 && section.month == month_minus2) {
                for entry in section.entries {
                    data_m2 -= entry.amount
                }
            }
        }
        
        
        var data_p1: Double = 0
        let currMonth_p1 = months[month_plus1-1]
        for section in Incomes {
            if (section.year == year_plus1 && section.month == month_plus1) {
                for entry in section.entries {
                    data_p1 += entry.amount
                }
            }
        }
        for section in Outcomes {
            if (section.year == year_plus1 && section.month == month_plus1) {
                for entry in section.entries {
                    data_p1 -= entry.amount
                }
            }
        }
        
        
        var data_p2: Double = 0
        let currMonth_p2 = months[month_plus2-1]
        for section in Incomes {
            if (section.year == year_plus2 && section.month == month_plus2) {
                for entry in section.entries {
                    data_p2 += entry.amount
                }
            }
        }
        for section in Outcomes {
            if (section.year == year_plus2 && section.month == month_plus2) {
                for entry in section.entries {
                    data_p2 -= entry.amount
                }
            }
        }
        
        
        dataEntries.append(BarChartDataEntry(x: 0, y: data_m2))
        dataEntries.append(BarChartDataEntry(x: 1, y: data_m1))
        dataEntries.append(BarChartDataEntry(x: 2, y: data))
        dataEntries.append(BarChartDataEntry(x: 3, y: data_p1))
        dataEntries.append(BarChartDataEntry(x: 4, y: data_p2))
        
        
        let reqMonths = [currMonth_m2, currMonth_m1, currMonth, currMonth_p1, currMonth_p2]
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Balance in \(NSLocalizedString("currency", comment: "currency"))")
        chartDataSet.colors = [UIColor(red: 100/255, green: 150/255, blue: 5/255, alpha: 1)]
        let chartData = BarChartData(dataSet: chartDataSet)
        balanceChart.data = chartData
        balanceChart.chartDescription?.text = ""
        balanceChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: reqMonths)
        balanceChart.xAxis.granularity = 1
        balanceChart.animate(xAxisDuration: 2.0, yAxisDuration: 3.0, easingOption: .easeOutBounce)
    }
    
    func getDataOutcomes() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Outcomes")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [Outcomes] {
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
                
                if !sectionContainsOutcome(month: month, year: year) {
                    Outcomes.append(SectionStructOutcome(month: month, year: year, entries: [EntryStructOutcome]()))
                }
                
                let entry = EntryStructOutcome(date: date, use: use, amount: amount, outcome: data)
                let index = getIndexOfOutcome(month: entry.date.month, year: entry.date.year)
                Outcomes[index].entries.append(entry)
                
                Outcomes.sort{ (lhs: SectionStructOutcome, rhs: SectionStructOutcome) -> Bool in
                    if lhs.year != rhs.year {
                        return lhs.year < rhs.year
                    } else {
                        return lhs.month < rhs.month
                    }
                }
                
                Outcomes[index].entries.sort{ (lhs: EntryStructOutcome, rhs: EntryStructOutcome) -> Bool in
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
    }
    
    func getDataIncomes() {
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
                
                if !sectionContainsIncome(month: month, year: year) {
                    Incomes.append(SectionStructIncome(month: month, year: year, entries: [EntryStructIncome]()))
                }
                
                let entry = EntryStructIncome(date: date, use: use, amount: amount, income: data)
                let index = getIndexOfIncome(month: entry.date.month, year: entry.date.year)
                Incomes[index].entries.append(entry)
                
                Incomes.sort{ (lhs: SectionStructIncome, rhs: SectionStructIncome) -> Bool in
                    if lhs.year != rhs.year {
                        return lhs.year < rhs.year
                    } else {
                        return lhs.month < rhs.month
                    }
                }
                
                Incomes[index].entries.sort{ (lhs: EntryStructIncome, rhs: EntryStructIncome) -> Bool in
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
    }
    
    
    func sectionContainsIncome(month: Int, year: Int) -> Bool {
        for sec in Incomes {
            if sec.month == month && sec.year == year {
                return true
            }
        }
        return false
    }
    
    func sectionContainsOutcome(month: Int, year: Int) -> Bool {
        for sec in Outcomes {
            if sec.month == month && sec.year == year {
                return true
            }
        }
        return false
    }
    
    
    func getIndexOfIncome(month: Int, year: Int) -> Int{
        var index = 0
        for sec in Incomes {
            if sec.month == month && sec.year == year {
                return index
            }
            index = index + 1
        }
        return index
    }
    
    func getIndexOfOutcome(month: Int, year: Int) -> Int{
        var index = 0
        for sec in Outcomes {
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
