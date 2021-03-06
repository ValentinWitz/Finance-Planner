//
//  IncomesView.swift
//  Finance Planner
//
//  Created by Valentin Witzeneder on 08.12.17.
//  Copyright © 2017 Valentin Witzeneder. All rights reserved.
//

import UIKit
import CoreData

class IncomesView: UITableViewController {

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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTableView()
    }

    func updateTableView (){
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
        self.tableView.reloadData()
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
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Sections[section].entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! customCell
        
        let entry = Sections[indexPath.section].entries[indexPath.row]
        let dateText = String.localizedStringWithFormat(NSLocalizedString(months[entry.date.month - 1], comment: "date"), String(entry.date.day), String(entry.date.year))
        cell.dateLabel?.text = dateText
        let amount = String(format: "%.2f", arguments: [entry.amount])
        cell.amountLabel?.text = "\(amount) \(NSLocalizedString("currency", comment: "currency"))"
        return cell
    }
 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let entry = Sections[indexPath.section].entries[indexPath.row]
            context.delete(entry.income)
            
            appDelegate.saveContext()
            updateTableView()
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let entry = Sections[section].entries
        if !entry.isEmpty {
            let sectionText = String.localizedStringWithFormat(NSLocalizedString("\(months[Sections[section].month - 1])Section", comment: "date"), String(Sections[section].year))
            return sectionText
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = Sections[indexPath.section].entries[indexPath.row]
        let amount = String(format: "%.2f", arguments: [entry.amount])
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        popOverVC.amountLabel.text? = "\(amount) \(NSLocalizedString("currency", comment: "currency"))"
        popOverVC.useLabel.text? = entry.use
        let dateText = String.localizedStringWithFormat(NSLocalizedString(months[entry.date.month - 1], comment: "date"), String(entry.date.day), String(entry.date.year))
        popOverVC.dateLabel.text? = dateText
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
