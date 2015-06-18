//
//  Avaliacao.swift
//  CollegeManager
//
//  Created by Jorge Henrique P. Garcia on 6/10/15.
//  Copyright (c) 2015 Fernando Lucheti. All rights reserved.
//

import Foundation
import CoreData
import CloudKit

@objc(Avaliacao)
class Avaliacao: NSManagedObject {
    
    @NSManaged var completo: NSNumber
    @NSManaged var dataEntrega: NSDate
    @NSManaged var dataFinal: NSDate
    @NSManaged var nome: String
    @NSManaged var nota: NSNumber
    @NSManaged var tipo: NSNumber
    @NSManaged var disciplina: Disciplina
    var sync = false

}


class AvaliacaoObj {
    
    var id: CKRecordID?
    
    var completo: NSNumber?
    var dataEntrega: NSDate?
    var dataFinal: NSDate?
    var nome: String?
    var nota: NSNumber?
    var tipo: NSNumber?
    var disciplina: Disciplina?
    
    convenience init(record: CKRecord, database: CKDatabase){
        self.init()
        
        id = record.recordID
        
        completo = record.objectForKey("completo") as? NSNumber
        dataEntrega = record.objectForKey("dataEntrega") as? NSDate
        dataFinal = record.objectForKey("dataFinal") as? NSDate
        nome = record.objectForKey("nome") as? String
        nota = record.objectForKey("nota") as? NSNumber
        tipo = record.objectForKey("tipo") as? NSNumber
        disciplina = record.objectForKey("disciplina") as? Disciplina
    }
    
}








