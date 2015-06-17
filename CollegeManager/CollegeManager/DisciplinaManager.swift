//
//  DisciplinaManager.swift
//  CollegeManager
//
//  Created by Jorge Henrique P. Garcia on 6/10/15.
//  Copyright (c) 2015 Fernando Lucheti. All rights reserved.
//

import CoreData
import UIKit

public class DisciplinaManager {
    
    static let sharedInstance = DisciplinaManager()
    static let entityName = "Disciplina"
    
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! HKAppDelegate
        var c = appDelegate.managedObjectContext
        return c!
        }()
    
    //    private init(){}
    
    
    func novaDisciplina() -> Disciplina
    {
        return NSEntityDescription.insertNewObjectForEntityForName(DisciplinaManager.entityName, inManagedObjectContext: managedContext) as! Disciplina
    }
    
    func salvar()
    {
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func buscarDisciplinas() -> Array<Disciplina>
    {
        let fetchRequest = NSFetchRequest(entityName: DisciplinaManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Disciplina] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        NSFetchRequest(entityName: "FetchRequest")
        
        return Array<Disciplina>()
    }
    
    
    
    
}
