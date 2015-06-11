//
//  Avaliacao.swift
//  CollegeManager
//
//  Created by Fernando Lucheti on 10/06/15.
//  Copyright (c) 2015 Fernando Lucheti. All rights reserved.
//

import Foundation
import CoreData


@objc(Avaliacao)
class Avaliacao: NSManagedObject {

    @NSManaged var completo: NSNumber
    @NSManaged var dataFinal: NSDate
    @NSManaged var disciplina: String
    @NSManaged var dataEntrega: NSDate
    @NSManaged var tipo: NSNumber
    @NSManaged var nome: String
    @NSManaged var nota: NSNumber

}
