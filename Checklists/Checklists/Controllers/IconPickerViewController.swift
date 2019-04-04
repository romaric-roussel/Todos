//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by lpiem on 22/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class IconPickerViewController: UITableViewController {
    
    var iconArray = [IconAsset]()
    var delegate : IconPickerViewControllerDelegate?
    var iconToEdit :IconAsset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for icon in IconAsset.allCases {
            iconArray.append(icon)
        }
    }
    
    //datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return lists.count
        return IconAsset.allCases.count
    }
    
    //delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconList", for: indexPath)
        //cell.textLabel?.text = lists[indexPath.row].name
        cell.textLabel?.text = iconArray[indexPath.row].rawValue
        cell.imageView?.image = iconArray[indexPath.row].image
        return cell
        
    }
    
    //deledgte too
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        iconToEdit = iconArray[indexPath.row]
        delegate?.IconListViewController(self, didFinishAddingIcon: iconToEdit!)
    }
    
    
    
}

protocol IconPickerViewControllerDelegate  {
    func IconListViewController(_ controller: IconPickerViewController, didFinishAddingIcon icon: IconAsset)
  
}
