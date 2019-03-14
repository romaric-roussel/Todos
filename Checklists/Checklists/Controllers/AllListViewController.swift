//
//  AllListViewController.swift
//  Checklists
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {
    
    var tableList  = ["liste 1","liste 2","liste3 "]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .addItem:
            // prepare for segue to Foo
            let navigation = segue.destination as! UINavigationController
            let controller = navigation.topViewController as! ItemDetailViewController
            controller.delegate = self
            controller.itemToEdit = nil
            break
        
        }
    }
    
    //datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableList.count    }
    
    //delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "checkList", for: indexPath)
        cell.textLabel?.text = tableList[indexPath.row]        
        return cell
        
    }
    
    
}

extension AllListViewController: SegueHandlerType {
    
    enum SegueIdentifier: String {
        //case addItem
        //case editItem
        
    }
}
