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

    var entryArray = Array(repeating: [String](), count: 12)
    var incomes = Array(repeating: [Incomes](), count: 12)
    var sections = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTableView()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sections = ["January", "February", "March", "April", "May", "Juny", "July", "August", "September", "October", "November", "December"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateTableView (){
        incomes.removeAll()
        incomes = Array(repeating: [Incomes](), count: 12)
        entryArray.removeAll()
        entryArray = Array(repeating: [String](), count: 12)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Incomes")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [Incomes] {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                let date = dateFormatter.string(from: data.date!)
                let amount = String(format: "%.2f", arguments: [data.amount])
                let entry = date + ": " + amount + "€"
                
                var i = 0
                for section in sections {
                    if date.contains(section){
                        incomes[i].append(data)
                        entryArray[i].append(entry)
                    }
                    i = i + 1
                }
            }
        } catch {
            print("Failed fetch")
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entryArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "customCell")
        cell.textLabel?.text = entryArray[indexPath.section][indexPath.row]
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
            
            let income = self.incomes[indexPath.section].remove(at: indexPath.row)
            context.delete(income)
            appDelegate.saveContext()
            
            updateTableView()
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
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
