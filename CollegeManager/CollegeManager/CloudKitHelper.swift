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
    var avaliacoes = [AvaliacaoObj]()
    
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
    
    func saveTodo(todo : NSString) {
        
        let todoRecord = CKRecord(recordType: "Todos")
        todoRecord.setValue(todo, forKey: "todotext")
        publicDB.saveRecord(todoRecord, completionHandler: { (record, error) -> Void in
            println("Before saving in cloud kit : \(self.todos.count)")
            println("Saved in cloudkit")
//            self.fetchTodos(record)
        })
    }
    
    func saveAvaliacao(avaliacao : Avaliacao) {
        
        let avaliRecord = CKRecord(recordType: "Avaliacao")
        
        avaliRecord.setValue(avaliacao.nome, forKey: "nome")
        avaliRecord.setValue(avaliacao.nota, forKey: "nota")
        
        publicDB.saveRecord(avaliRecord, completionHandler: { (record, error) -> Void in
            println("Before saving in cloud kit: \(self.avaliacoes.count)")
            println("Saved in cloudkit")
            self.avaliacoes = self.fetchAvaliacao(record, queryString: "")
        })
    }
    
    func fetchAvaliacao(insertedRecord: CKRecord?, queryString: String) -> [AvaliacaoObj] {
        
        var tempAval = [AvaliacaoObj]()
        
        let predicate = NSPredicate(value: true)
        
//        Predicate example
//        predicate = NSPredicate(format: "")   //get error
//        predicate = [NSPredicate predicateWithFormat:@"ANY favoriteColors = 'red'"];
//        predicate = [NSPredicate predicateWithFormat:@"favoriteColors CONTAINS 'red'"];

        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: "Avaliacao", predicate:  predicate)
        query.sortDescriptors = [sort]
        
        publicDB.performQuery(query, inZoneWithID: nil) {
            results, error in
            
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.errorUpdating(error)
                    return
                }
            } else {
//                self.avaliacoes.removeAll()
                
                
                for record in results{
                    let avaliacao = AvaliacaoObj(record: record as! CKRecord, database: self.publicDB)
                    
//                    self.avaliacoes.append(avaliacao)
                    tempAval.append(avaliacao)
                }
                if let tmp = insertedRecord {   //Pode passar 'nil' pro record se n tiver
                    let avaliacao = AvaliacaoObj(record: insertedRecord! as CKRecord, database: self.publicDB)
                    
                    /* Work around at the latest entry at index 0 */
                    tempAval.insert(avaliacao, atIndex: 0)
                }
                
                println("fetch after save : \(self.avaliacoes.count)")
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.modelUpdated()
                    
                    
                    // teste ---------------------
                    for obj in tempAval {
                        println("\(obj.nome!) - \(obj.nota!)")
                    }
                    // ---------------------------
                    
                    return
                }
            }
        }
        
        return tempAval
    }
    
    
}

