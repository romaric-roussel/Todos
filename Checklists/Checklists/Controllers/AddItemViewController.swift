//
//  AddItemViewController.swift
//  Checklists
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet weak var itemText: UITextField!
    @IBOutlet weak var btnDone: UIBarButtonItem!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    
     @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
     @IBAction func done() {
        print(itemText.text!)
        dismiss(animated: true, completion: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        itemText.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if let oldString = textField.text {
            let newString = oldString.replacingCharacters(in: Range(range, in: oldString)!,
                                                          with: string)
            
            if((newString.isEmpty)){
                btnDone.isEnabled = false
                
            }else {
                btnDone.isEnabled = true
            }
            
        }
        return true
    }
        
    
}
