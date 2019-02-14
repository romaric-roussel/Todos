//
//  ChecklistViewController.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var checklistArray = [ChecklistItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        checklistArray.append(ChecklistItem(text: "Tennis", checked: true))
        checklistArray.append(ChecklistItem(text: "React", checked: false))
        checklistArray.append(ChecklistItem(text: "Swift"))
        checklistArray.append(ChecklistItem(text: "MHW"))
        
    }
    
    //datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklistArray.count    }
    
    //delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    
        configureCheckmark(for: cell, withItem: checklistArray[indexPath.item])
        configureText(for: cell, withItem: checklistArray[indexPath.item])
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: ChecklistItem){
        cell.accessoryType = item.checked ? .checkmark : .none
        
    }
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem){
            cell.textLabel?.text = item.text
    }


}

