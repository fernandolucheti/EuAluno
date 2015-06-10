//
//  Avaliacao.swift
//  MultipleDetailViews
//
//  Created by Jorge Henrique P. Garcia on 6/10/15.
//  Copyright (c) 2015 PTS. All rights reserved.
//

import Foundation
import CoreData

@objc(Avaliacao)
class Avaliacao: NSManagedObject {

    @NSManaged var nome: String
    @NSManaged var disciplina: String
    @NSManaged var tipo: NSNumber
    @NSManaged var dataHora: NSDate
    @NSManaged var dtEntrega: NSDate
    @NSManaged var completo: NSNumber
    @NSManaged var nota: NSNumber

}
