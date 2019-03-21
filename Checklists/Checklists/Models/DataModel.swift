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
    private init(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(saveChecklist),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil)
    }
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
    
    @objc func saveChecklist() {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            try encoder.encode(lists).write(to: dataFileUrl)
        } catch {
            print("error")
        }
    }
    
    func loadChecklist() {
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
    
    func sortChecklists() {
        lists.sort {
            $0.name.localizedCompare($1.name) == .orderedAscending
        }
        
        
    }
}

