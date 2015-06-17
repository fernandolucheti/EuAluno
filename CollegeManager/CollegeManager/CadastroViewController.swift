//
//  CadastroViewController.swift
//  CollegeManager
//
//  Created by Fernando Lucheti on 10/06/15.
//  Copyright (c) 2015 Fernando Lucheti. All rights reserved.
//

import Foundation
import UIKit

class CadastroViewController: UINavigationController{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationBar.backItem?.title = "voltar"
    }
    @IBAction func didPressSaveButton(sender: UIBarButtonItem) {
        //implement save methods
        
        let disciplinaManager = DisciplinaManager.sharedInstance
        let avaliacaoManager = AvaliacaoManager.sharedInstance
        
        //Nova disciplina
        var newDisciplina = disciplinaManager.novaDisciplina()
        newDisciplina.nome = subjectLabel.text!
        
        var avaliacao = avaliacaoManager.novaAvaliacao()
        avaliacao.nome = nameLabel.text!
        avaliacao.nota = 6                                      // Falta adicionar
        avaliacaoManager.salvar()
        
        newDisciplina.addAvaliacao(avaliacao)
        
        // Teste pra exibir --------
        let ss = avaliacaoManager.buscarAvaliacoes()[0].nome
        let rr = avaliacaoManager.buscarAvaliacoes()[0].nota
        println("\(ss) - \(rr)")
        // --------------
        
        //Alert with some message
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func didPressBackButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}