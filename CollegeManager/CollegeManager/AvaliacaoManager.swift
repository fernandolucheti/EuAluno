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
    var avaliacao: Avaliacao?   //Recebe o objeto do managedContext
    
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! HKAppDelegate
        var c = appDelegate.managedObjectContext
        return c!
    }()
    
//    private init(){}
    
    
    func novaAvaliacao() -> Avaliacao
    {
        avaliacao = NSEntityDescription.insertNewObjectForEntityForName(AvaliacaoManager.entityName, inManagedObjectContext: managedContext) as? Avaliacao
        return avaliacao!
    }
    
    func salvar()
    {
        var error:NSError?
        managedContext.save(&error)
        
        let ckh = CloudKitHelper()
        ckh.saveAvaliacao(avaliacao!)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func buscarAvaliacoes() -> Array<Avaliacao>
    {
        let fetchRequest = NSFetchRequest(entityName: AvaliacaoManager.entityName)
        
        // Create a sort descriptor object that sorts on the "dataFinal"
        let sortDescriptor = NSSortDescriptor(key: "dataFinal", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Create a new predicate that filters out any object before today.
        let predicate = NSPredicate(format: "dataFinal >= %@", NSDate())
        
        fetchRequest.predicate = predicate
        
        
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
