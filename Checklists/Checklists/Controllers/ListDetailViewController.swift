//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by lpiem on 21/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit


class ListDetailViewController : UITableViewController,UITextFieldDelegate {
      
    @IBOutlet weak var btnDoneList: UIBarButtonItem!
    @IBOutlet weak var btnCancelList: UIBarButtonItem!
    @IBOutlet weak var listItemText: UITextField!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var iconText: UILabel!
    
    
    var delegate : ListDetailViewControllerDelegate?
    var listToEdit :Checklist?
    var iconChoose : IconAsset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ivIcon.image = listToEdit?.icon.image
        if(listToEdit != nil){
            //modif
            self.title = "Edit List"
            listItemText.text = listToEdit?.name
        } else {
            btnDoneList.isEnabled = false
            iconChoose = IconAsset.Folder
            ivIcon.image = iconChoose?.image
            iconText.text = "Icon"
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    @IBAction func Cancel() {
         delegate?.ListDetailViewControllerDidCancel(self)
    }
    
    
    @IBAction func Done() {
        if(listToEdit != nil){
            listToEdit?.name = listItemText.text!
            delegate?.ListDetailViewController(self, didFinishEditingList: listToEdit!)
        }else {
            delegate?.ListDetailViewController(self, didFinishAddingList: Checklist(name: listItemText.text!,icon:iconChoose))
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        listItemText.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .showIconList:
            // prepare for segue to Foo
            let delegage = segue.destination as! IconPickerViewController
            delegage.delegate = self
            //controller.iconToEdit = listToEdit?.icon != nil ? listToEdit?.icon : nil
            //delegate.list = lists[indexForSelectedItem!.row]
            
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if let oldString = textField.text {
            let newString = oldString.replacingCharacters(in: Range(range, in: oldString)!,
                                                          with: string)
            if(!newString.isEmpty){
                btnDoneList.isEnabled = true
            } else {
                btnDoneList.isEnabled = false
            }
            
        }
        return true
    }
    
    
    
}
protocol ListDetailViewControllerDelegate  {
    func ListDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func ListDetailViewController(_ controller: ListDetailViewController, didFinishAddingList item: Checklist)
    func ListDetailViewController(_ controller: ListDetailViewController, didFinishEditingList item: Checklist)
}

extension ListDetailViewController: SegueHandlerType {
    
    enum SegueIdentifier: String {
        case showIconList
    }
}

extension ListDetailViewController : IconPickerViewControllerDelegate{
    func IconListViewController(_ controller: IconPickerViewController, didFinishAddingIcon icon: IconAsset) {
        ivIcon.image = icon.image
        iconChoose = icon
        if(listToEdit != nil){
            listToEdit?.icon = icon
        }
        navigationController?.popViewController(animated: true)
    }
    
    
   
    
    
    
    
}
    

