//
//  Checklist.swift
//  Checklists
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import Foundation

class Checklist : Codable {
    var name: String
    var items: [ChecklistItem]
    var uncheckedItemsCount : Int {
        get {
           return items.filter({!$0.checked}).count
        }
    }
    var icon : IconAsset
    
    init(name:String, items : [ChecklistItem]? = [ChecklistItem](),icon:IconAsset? = IconAsset.NoIcon){
        self.name = name
        self.items = items!
        self.icon = icon!
    }
    

}

