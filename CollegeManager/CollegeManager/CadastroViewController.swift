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
        
        
        let disciplinaManager = DisciplinaManager()
        let disciplinaArray = disciplinaManager.buscarDisciplinas()
        var disciplinas = NSMutableArray()
        for d in disciplinaArray {
            disciplinas.addObject(d.nome)
        }
        
        downPicker = DownPicker(textField: disciplinaTextField, withData: disciplinas)   //Colocar array de Disciplinas
    }
    
    @IBAction func addDisciplinaButtonPressed(sender: UIButton) {
        
        var mainStoryboard = self.storyboard
        var vc = mainStoryboard!.instantiateViewControllerWithIdentifier("CadastroDisciplina") as! UIViewController
        vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    @IBAction func CancelButton(sender: UIButton) {

        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /// Implement save methods
    @IBAction func SaveButton(sender: UIButton) {
        
        let avaliacaoManager = AvaliacaoManager.sharedInstance
        
        var avaliacao = avaliacaoManager.novaAvaliacao()
        avaliacao.nome = nameTextField.text!
        avaliacao.dataEntrega = datePicker.date
        avaliacao.completo = 0
        avaliacao.tipo = 1
        let disciplinaManager = DisciplinaManager()
        avaliacao.disciplina = disciplinaManager.buscarDisciplina(disciplinaTextField.text)
//        avaliacao.nota = 6                                      // Falta adicionar
        avaliacaoManager.salvar()
        
        
        // Teste pra exibir --------
        let ss = avaliacaoManager.buscarAvaliacoes()[0].nome
        let rr = avaliacaoManager.buscarAvaliacoes()[0].nota
        println("\(ss) - \(rr)")
        // --------------
        
        //Alert with some message
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}