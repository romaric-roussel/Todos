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
    var list: Checklist!
    /*var documentDirectory: URL {
        get {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        }
    }
    var dataFileUrl: URL {
        get {
            var path : URL
            let file = "Checklists"
            let ext = "json"
            path = documentDirectory.appendingPathComponent(file).appendingPathExtension(ext)
            return path
        }
    }*/
    //var itemToEdit
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = list.name
        //checklistArray = list.items
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
        case .editItem:
            let navigation = segue.destination as! UINavigationController
            let controller = navigation.topViewController as! ItemDetailViewController
            controller.delegate = self
            let cell = sender as? ChecklistItemCell
            let indexForSelectedItem = tableView.indexPath(for: cell!)
            //controller.itemToEdit = checklistArray[indexForSelectedItem!.row]
            controller.itemToEdit = list.items[indexForSelectedItem!.row]

            break
            
        }
        
    }
    
    //datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.items.count    }
    
    //delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    
        configureCheckmark(for: cell as! ChecklistItemCell, withItem: list.items[indexPath.item])
        configureText(for: cell as! ChecklistItemCell, withItem: list.items[indexPath.item])
        
        return cell

    }
    
    //deledgte too
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        list.items[indexPath.item].toggleChecked()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func configureCheckmark(for cell: ChecklistItemCell, withItem item: ChecklistItem){
        
        cell.lbChecked.isHidden = !item.checked
        //saveChecklistItems()

        //cell.accessoryType = item.checked ? .checkmark : .none
        
    }
    func configureText(for cell: ChecklistItemCell, withItem item: ChecklistItem){
            //cell.textLabel?.text = item.text
        cell.lblibelle.text = item.text
        //saveChecklistItems()

    }
    
    
    func addDummyTodo(item : ChecklistItem) {
        list.items.append(item)
        tableView.insertRows(at: [IndexPath(row: checklistArray.count - 1, section: 0)], with:.automatic)
        //saveChecklistItems()
        
    }
    func updateDummyTodo(item : ChecklistItem,index :Int) {
        list.items[index].text = item.text
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        //saveChecklistItems()
    }
    
    /*func saveChecklistItems() {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            try encoder.encode(checklistArray).write(to: dataFileUrl)
        } catch {
            print("error")
        }
    }
    
    func loadChecklistItems() {
        do {
            // Decode data to object
            let jsonDecoder = JSONDecoder()
            let data : Data = try Data(contentsOf: dataFileUrl)
            checklistArray =  try jsonDecoder.decode([ChecklistItem].self, from: data)
        }
        catch {
            print(error)
        }
        
    }*/
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            //saveChecklistItems()
        }
    }
}

extension ChecklistViewController : itemDetailViewControllerDelegate{
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
       controller.dismiss(animated: true, completion: nil)
        addDummyTodo(item: item)
    }
    
    func itemDetailViewController(_ controller:ItemDetailViewController,didFinishEditingItem item:ChecklistItem) {
        controller.dismiss(animated: true, completion: nil)
        let index = list.items.index(where : {
            $0 === item
        })
        updateDummyTodo(item: item, index: index!)
    }
    
    
}

extension ChecklistViewController: SegueHandlerType {
    
    enum SegueIdentifier: String {
        case addItem
        case editItem
        
    }
}
    


