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
    var disciplina: Disciplina?
    
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! HKAppDelegate
        var c = appDelegate.managedObjectContext
        return c!
    }()
    
    //    private init(){}
    
    
    func novaDisciplina() -> Disciplina
    {
        disciplina = NSEntityDescription.insertNewObjectForEntityForName(DisciplinaManager.entityName, inManagedObjectContext: managedContext) as? Disciplina
        return disciplina!
    }
    
    func salvar()
    {
        var error:NSError?
        managedContext.save(&error)
        
        let ckh = CloudKitHelper()
        ckh.saveDisciplina(disciplina!)
        
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
    
    func buscarDisciplina(nome: String) -> Disciplina{ //Pra fazer o relacionamento
            
        var id: String?
        
        let fetchRequest = NSFetchRequest(entityName: DisciplinaManager.entityName)
        
        // Create a new predicate that filters out any object before today.
        let predicate = NSPredicate(format: "nome == %@", nome)
        fetchRequest.predicate = predicate
        
        var error:NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Disciplina] {
            return results[0]
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        return Disciplina()
    }
    
    func getAvaliacoes(nomeDis: String) -> Array<Avaliacao> {
        
        var avaliacoes = Array<Avaliacao>()
        
        let fetchRequest = NSFetchRequest(entityName: DisciplinaManager.entityName)
        
        // Create a new predicate that filters what we want.
        let predicate = NSPredicate(format: "nome == %@", nomeDis)
        fetchRequest.predicate = predicate
        
        var error:NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Disciplina] {
            
            let sortDescriptor = NSSortDescriptor(key: "dataFinal", ascending: false)
            
            avaliacoes = results[0].avaliacoes.sortedArrayUsingDescriptors([sortDescriptor]) as! Array<Avaliacao>
            
            return avaliacoes
            
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        return avaliacoes
    }
    
    
    
    
    
}
