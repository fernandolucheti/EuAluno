//
//  Avaliacao.swift
//  CollegeManager
//
//  Created by Jorge Henrique P. Garcia on 6/10/15.
//  Copyright (c) 2015 Fernando Lucheti. All rights reserved.
//

import Foundation
import CoreData

@objc(Avaliacao)
class Avaliacao: NSManagedObject {

    @NSManaged var completo: NSNumber
    @NSManaged var dataEntrega: NSDate
    @NSManaged var dataFinal: NSDate
    @NSManaged var nome: String
    @NSManaged var nota: NSNumber
    @NSManaged var tipo: NSNumber
    @NSManaged var disciplina: Disciplina

}
