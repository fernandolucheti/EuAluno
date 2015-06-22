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

    override func viewDidAppear(animated: Bool) {

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("reload"), name: "newDisciplina", object: nil)
    }
    func reload(){
        let disciplinaManager = DisciplinaManager()
        let disciplinaArray = disciplinaManager.buscarDisciplinas()
        var disciplinas = NSMutableArray()
        for d in disciplinaArray {
            disciplinas.addObject(d.nome)
        }
        downPicker = DownPicker(textField: disciplinaTextField, withData: disciplinas)
    }
    override func viewDidLoad() {

        // Set datePicker to start counting from tomorrow.
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()

        components.day = 1

        let tomorrow = calendar.dateByAddingComponents(components, toDate: NSDate(), options: nil)

        datePicker.minimumDate = tomorrow

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
        downPicker = DownPicker(textField: disciplinaTextField, withData: disciplinas)
        
        
        //downPicker = DownPicker(textField: disciplinaTextField, withData: disciplinas)   //Colocar array de Disciplinas
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.nameTextField.resignFirstResponder()
    }
    
    @IBAction func backButton(sender: UIButton) {
         self.dismissViewControllerAnimated(true, completion: nil)
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

        // Add event notifications.
        NotificationController().setReminder(avaliacao)

        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "newTrabalho", object: nil))
        // Teste pra exibir --------
        //let ss = avaliacaoManager.buscarAvaliacoes()[0].nome
        //let rr = avaliacaoManager.buscarAvaliacoes()[0].nota
//        println("\(ss) - \(rr)")
        // --------------
        
        //Alert with some message
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}