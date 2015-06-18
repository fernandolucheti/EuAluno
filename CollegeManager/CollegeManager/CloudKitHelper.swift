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


class CloudKitHelper: NSObject {
    var container : CKContainer
//    var publicDB : CKDatabase
    let privateDB : CKDatabase
    var delegate : CloudKitDelegate?
    var avaliacoes = [AvaliacaoObj]()
    
//    class Todos {
//        
//        var name: String?
//        var text: String?
//        
//        convenience init(record: CKRecord, database: CKDatabase) {
//            self.init()
//            
//            name = record.recordID.recordName
//            text = record.objectForKey("todotext") as? String
//        }
//    }
    
    static let sharedInstance = CloudKitHelper()
    
    override init() {
        
        container = CKContainer.defaultContainer()
//        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
    }
    
    func saveAvaliacao(avaliacao : Avaliacao) {
        
        let avaliRecord = CKRecord(recordType: "Avaliacao")
        
        avaliRecord.setValue(avaliacao.nome, forKey: "nome")
        avaliRecord.setValue(avaliacao.nota, forKey: "nota")
        avaliRecord.setValue(avaliacao.dataEntrega, forKey: "dataEntrega")
        avaliRecord.setValue(avaliacao.entregueEm, forKey: "entregueEm")
        avaliRecord.setValue(avaliacao.completo, forKey: "completo")
        avaliRecord.setValue(avaliacao.tipo, forKey: "tipo")
        
        privateDB.saveRecord(avaliRecord, completionHandler: { (record, error) -> Void in
            println("Saved in cloudkit")
            self.avaliacoes = self.fetchAvaliacao(record, complete: {})
        })
    }
    
    func saveDisciplina(disciplina : Disciplina) {
        
        let disRecord = CKRecord(recordType: "Disciplina")
        
        disRecord.setValue(disciplina.nome, forKey: "nome")
        
        privateDB.saveRecord(disRecord, completionHandler: { (record, error) -> Void in
            println("Saved in cloudkit")
//            self.disciplinas = self.fetchDisciplina(record, queryString: "")
        })
    }
    
    func fetchAvaliacao(insertedRecord: CKRecord?, complete: ()->() ) -> [AvaliacaoObj] { //Passar nulo se nao tiver (queryString sem uso)
        
        var tempAval = [AvaliacaoObj]()
        
        let predicate = NSPredicate(value: true)

        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: "Avaliacao", predicate:  predicate)
        query.sortDescriptors = [sort]
        
        privateDB.performQuery(query, inZoneWithID: nil) {
            results, error in
            
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.errorUpdating(error)
                    return
                }
            } else {
//                self.avaliacoes.removeAll()
                
                for record in results{
                    let avaliacao = AvaliacaoObj(record: record as! CKRecord, database: self.privateDB)
                    
//                    self.avaliacoes.append(avaliacao)
                    tempAval.append(avaliacao)
                }
                if let tmp = insertedRecord {   //Pode passar 'nil' pro record se n tiver
                    let avaliacao = AvaliacaoObj(record: insertedRecord! as CKRecord, database: self.privateDB)
                    
                    /* Work around at the latest entry at index 0 */
                    tempAval.insert(avaliacao, atIndex: 0)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.modelUpdated()
                    println("Fetch after save: \(tempAval.count)")
                    
                    self.avaliacoes = tempAval
                    
                    complete()
                    
                    // teste exibir ---------------------
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
    
    func syncToCoreData(){
        
        let avaliacaoManager = AvaliacaoManager.sharedInstance
        var avaliacaoArray = Array<AvaliacaoObj>()
        
        self.fetchAvaliacao(nil) {
            
            for a in self.avaliacoes {
                
                var avaliacao = avaliacaoManager.novaAvaliacao()
                avaliacao.nome = a.nome!
                avaliacao.dataEntrega = a.dataEntrega!
                avaliacao.completo = a.completo!
                avaliacao.tipo = a.tipo!
                avaliacao.sync = true
                
                if let entregueEm = a.entregueEm {
                    avaliacao.entregueEm = entregueEm
                }
                if let nota = a.nota {
                    avaliacao.nota = nota
                }
                
                
                // let disciplinaManager = DisciplinaManager()
                // avaliacao.disciplina = disciplinaManager.buscarDisciplina(disciplinaTextField.text)
                
                // avaliacao.nota = 6                                      // Falta adicionar
                avaliacaoManager.salvar()
            }
            
        }
        
    }
    
    
}

