//
//  AvaliacaoManager.swift
//  MultipleDetailViews
//
//  Created by Jorge Henrique P. Garcia on 6/10/15.
//  Copyright (c) 2015 PTS. All rights reserved.
//

import CoreData
import UIKit

public class AvaliacaoManager {
   
    static let sharedInstance = AvaliacaoManager()
    static let entityName = "Avaliacao"
    
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! HKAppDelegate
        var c = appDelegate.managedObjectContext
        return c!
    }()
    
//    private init(){}
    
    
    func novaAvaliacao() -> Avaliacao
    {
        return NSEntityDescription.insertNewObjectForEntityForName(AvaliacaoManager.entityName, inManagedObjectContext: managedContext) as! Avaliacao
    }
    
    func salvar()
    {
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func buscarProdutos() -> Array<Avaliacao>
    {
        let fetchRequest = NSFetchRequest(entityName: AvaliacaoManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Avaliacao] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        return Array<Avaliacao>()
    }

    
    
    
}
