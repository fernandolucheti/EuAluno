//
//  Disciplina.swift
//  CollegeManager
//
//  Created by Jorge Henrique P. Garcia on 6/10/15.
//  Copyright (c) 2015 Fernando Lucheti. All rights reserved.
//

import Foundation
import CoreData
import CloudKit

@objc(Disciplina)
class Disciplina: NSManagedObject {

    @NSManaged var nome: String
    @NSManaged var avaliacoes: NSSet
    
    func addAvaliacao(avaliacao: Avaliacao) {
        var avaliacoes = self.mutableSetValueForKey("avaliacoes")
        avaliacoes.addObject(avaliacao)
        
        //
    }
}
