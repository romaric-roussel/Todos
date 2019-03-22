//
//  AllListViewController.swift
//  Checklists
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {
    
    /*var lists  = [Checklist]()
    var checklist = [ChecklistItem]()*/
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(dataFileUrl)
        /*checklist.append(ChecklistItem(text: "mhw"))
        checklist.append(ChecklistItem(text: "react",checked: true))
        
        lists.append(Checklist(name: "liste 1"))
        lists.append(Checklist(name: "liste 2"))
        for item in lists {
            item.items = [ChecklistItem(text: "Item for " + item.name)]
            //print(item.name)
            //print(item.items[0].text)

        }*/


        
    }
    override func awakeFromNib() {
        //loadChecklistItems()
        DataModel.sharedInstance.loadChecklist()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .SeeList:
            // prepare for segue to Foo
            let delegate = segue.destination as! ChecklistViewController
            let cell = sender as? UITableViewCell
            let indexForSelectedItem = tableView.indexPath(for: cell!)
            //delegate.list = lists[indexForSelectedItem!.row]
            delegate.list = DataModel.sharedInstance.lists[indexForSelectedItem!.row]

            break
        case .AddList:
            // prepare for segue to Foo
            let navigation = segue.destination as! UINavigationController
            let controller = navigation.topViewController as! ListDetailViewController
            controller.delegate = self
            controller.listToEdit = nil
            break
        case .EditList:
            let navigation = segue.destination as! UINavigationController
            let controller = navigation.topViewController as! ListDetailViewController
            controller.delegate = self
            let cell = sender as? UITableViewCell
            let indexForSelectedItem = tableView.indexPath(for: cell!)
            //controller.listToEdit = lists[indexForSelectedItem!.row]
            controller.listToEdit = DataModel.sharedInstance.lists[indexForSelectedItem!.row]

            break
        
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        DataModel.sharedInstance.sortChecklists()
        
    }
    
    //datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return lists.count
        return DataModel.sharedInstance.lists.count
    }
    
    //delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckList", for: indexPath)
        //cell.textLabel?.text = lists[indexPath.row].name
        cell.textLabel?.text = DataModel.sharedInstance.lists[indexPath.row].name
        cell.imageView?.image = DataModel.sharedInstance.lists[indexPath.row].icon.image
        switch DataModel.sharedInstance.lists[indexPath.row].uncheckedItemsCount {
        case 0:
            if(DataModel.sharedInstance.lists[indexPath.row].items.count == 0){
                cell.detailTextLabel?.text = "No Item"
            }else {
                cell.detailTextLabel?.text = "All Done!"
            }
            break
        case 1... :
            cell.detailTextLabel?.text = String( DataModel.sharedInstance.lists[indexPath.row].uncheckedItemsCount)
            break
        default:
            break
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //lists.remove(at: indexPath.row)
            DataModel.sharedInstance.lists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            //saveChecklistItems()
        }
    }
    
    /*func saveChecklistItems() {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            try encoder.encode(lists).write(to: dataFileUrl)
        } catch {
            print("error")
        }
    }
    
    func loadChecklistItems() {
        do {
            // Decode data to object
            let jsonDecoder = JSONDecoder()
            let data : Data = try Data(contentsOf: dataFileUrl)
            lists =  try jsonDecoder.decode([Checklist].self, from: data)
        }
        catch {
            print(error)
        }
        
    }*/
    
    func addDummyTodo(item : Checklist) {
        //lists.append(item)
        DataModel.sharedInstance.lists.append(item)
        tableView.insertRows(at: [IndexPath(row: DataModel.sharedInstance.lists.count - 1, section: 0)], with:.automatic)
        //saveChecklistItems()
        
    }
    func updateDummyTodo(item : Checklist,index :Int) {
        //lists[index].name = item.name
        DataModel.sharedInstance.lists[index].name = item.name
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        //saveChecklistItems()
    }
    
    
    
    
    
    
}
extension AllListViewController : ListDetailViewControllerDelegate{
    func ListDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func ListDetailViewController(_ controller: ListDetailViewController, didFinishAddingList item: Checklist) {
        controller.dismiss(animated: true, completion: nil)
        addDummyTodo(item: item)
    }
    
    func ListDetailViewController(_ controller: ListDetailViewController, didFinishEditingList item: Checklist) {
        controller.dismiss(animated: true, completion: nil)
        /*let index = lists.index(where : {
            $0 === item
        })*/
        let index = DataModel.sharedInstance.lists.index(where : {
            $0 === item
        })
        updateDummyTodo(item: item, index: index!)
    }
    
    
    
    
}

extension AllListViewController: SegueHandlerType {
    
    enum SegueIdentifier: String {
        case SeeList
        case AddList
        case EditList
        
    }
}
