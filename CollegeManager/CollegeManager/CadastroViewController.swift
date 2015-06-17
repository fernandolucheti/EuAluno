//
//  CadastroViewController.swift
//  CollegeManager
//
//  Created by Fernando Lucheti on 10/06/15.
//  Copyright (c) 2015 Fernando Lucheti. All rights reserved.
//

import Foundation
import UIKit

class CadastroViewController: UIViewController{
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var disciplinaTextField: UITextField!
    var downPicker: DownPicker?

    
    override func viewDidLoad() {
//        super.viewDidLoad()
//        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"b"];
        

        //self.view.backgroundColor = UIColor.whiteColor()
        // self.navigationBar.backItem?.title = "voltar"
        
        
        
        var ss = NSMutableArray(array: ["teste1", "teste2", "teste1"])
        downPicker = DownPicker(textField: disciplinaTextField, withData: ss)   //Colocar array de Disciplinas

    }
    
    @IBAction func CancelButton(sender: UIButton) {

        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func SaveButton(sender: UIButton) {
        // implement save
        //implement save methods
        
        let disciplinaManager = DisciplinaManager.sharedInstance
        let avaliacaoManager = AvaliacaoManager.sharedInstance
        
        //Nova disciplina
        var newDisciplina = disciplinaManager.novaDisciplina()
        newDisciplina.nome = disciplinaTextField.text!
        
        var avaliacao = avaliacaoManager.novaAvaliacao()
        avaliacao.nome = nameTextField.text!
        avaliacao.dataFinal = datePicker.date
        avaliacao.completo = 0
        avaliacao.tipo = 1
//        avaliacao.nota = 6                                      // Falta adicionar
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
    
}