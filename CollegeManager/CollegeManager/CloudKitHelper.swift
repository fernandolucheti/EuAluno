//
//  CloudKitHelper.swift
//  CollegeManager
//
//  Created by Jorge Henrique P. Garcia on 6/11/15.
//  Copyright (c) 2015 Fernando Lucheti. All rights reserved.
//

import Foundation
import CloudKit

protocol CloudKitDelegate {
    func errorUpdating(error: NSError)
    func modelUpdated()
}


class CloudKitHelper {
    var container : CKContainer
    var publicDB : CKDatabase
    let privateDB : CKDatabase
    var delegate : CloudKitDelegate?
    var todos = [Todos]()
    
    class Todos {
        
        var name: String?
        var text: String?
        
        convenience init(record: CKRecord, database: CKDatabase) {
            self.init()
            
            name = record.recordID.recordName
            text = record.objectForKey("todotext") as? String
        }
    }
    
    static let sharedInstance = CloudKitHelper()
    
    init() {
        container = CKContainer.defaultContainer()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
    }
    
    func saveRecord(todo : NSString) {
        let todoRecord = CKRecord(recordType: "Todos")
        todoRecord.setValue(todo, forKey: "todotext")
        publicDB.saveRecord(todoRecord, completionHandler: { (record, error) -> Void in
            println("Before saving in cloud kit : \(self.todos.count)")
            println("Saved in cloudkit")
            self.fetchTodos(record)
        })
        
    }
    
    func fetchTodos(insertedRecord: CKRecord?) {
        
        let predicate = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: "Todos", predicate:  predicate)
        query.sortDescriptors = [sort]
        
        publicDB.performQuery(query, inZoneWithID: nil) {
            results, error in
            
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.errorUpdating(error)
                    return
                }
            } else {
                self.todos.removeAll()
                for record in results{
                    let todo = Todos(record: record as! CKRecord, database: self.publicDB)
                    self.todos.append(todo)
                }
                if let tmp = insertedRecord {
                    let todo = Todos(record: insertedRecord! as CKRecord, database: self.publicDB)
                    /* Work around at the latest entry at index 0 */
                    self.todos.insert(todo, atIndex: 0)
                }
                println("fetch after save : \(self.todos.count)")
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.modelUpdated()
                    
                    
                    // teste ---------------------
                    for ck in self.todos {
                        println("\(ck.name!) - \(ck.text!)")
                    }
                    // -------------------
                    
                    
                    return
                }
            }
        }
        
        
        
    }



    
    
    
}

