//
//  AddItemViewController.swift
//  Checklists
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
    
    
     @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
     @IBAction func done() {
        print(itemText?.text)
        dismiss(animated: true, completion: nil)

    }
    @IBOutlet weak var itemText: UITextField!
    
}
