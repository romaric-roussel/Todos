//
//  DataModel.swift
//  Checklists
//
//  Created by lpiem on 21/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class DataModel {
    
    static let sharedInstance = DataModel()
    private init(){}
    var lists  = [Checklist]()
    var checklist = [ChecklistItem]()
    
    var documentDirectory: URL {
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
    }
    
    func saveChecklistItems() {
        
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
        
    }
}

