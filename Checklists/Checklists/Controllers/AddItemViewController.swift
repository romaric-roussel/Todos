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
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    @IBOutlet weak var btnDone: UIBarButtonItem!
    
    
    var delegate : AddItemViewControllerDelegate?
    var itemToEdit :ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(itemToEdit != nil){
            //modif
            self.title = "Edit item"
            itemText.text = itemToEdit?.text        
        } else {
            btnDone.isEnabled = false
        }
      
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    

    
    
    @IBAction func cancel() {
        //dismiss(animated: true, completion: nil)
        delegate?.addItemViewControllerDidCancel(self)
        
    }
    
    @IBAction func done() {
        //print(itemText.text!)
        //dismiss(animated: true, completion: nil)
        if(itemToEdit != nil){
            itemToEdit?.text = itemText.text!
            delegate?.addItemViewController(self, didFinishEditingItem: itemToEdit!)
        }else {
            delegate?.addItemViewController(self, didFinishAddingItem: ChecklistItem(text: itemText.text!))

        }
  
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
            if(!newString.isEmpty){
                btnDone.isEnabled = true
            } else {
                btnDone.isEnabled = false
            }
            
        }
        return true
    }
    
        
    
}
protocol AddItemViewControllerDelegate  {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    func addItemViewController(_ controller:AddItemViewController,didFinishEditingItem item:ChecklistItem)
}



