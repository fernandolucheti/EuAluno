//
//  CadastroViewController.swift
//  CollegeManager
//
//  Created by Fernando Lucheti on 10/06/15.
//  Copyright (c) 2015 Fernando Lucheti. All rights reserved.
//

import Foundation
import UIKit

class CadastroDisciplinaViewController: UIViewController{
    
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        //        super.viewDidLoad()
        //        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        //        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"b"];
        
        
        //self.view.backgroundColor = UIColor.whiteColor()
        // self.navigationBar.backItem?.title = "voltar"
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.nameTextField.resignFirstResponder()
    }
    override func viewDidAppear(animated: Bool) {
        
    }
    @IBAction func backButton(sender: UIButton) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func CancelButton(sender: UIButton) {
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func SaveButton(sender: UIButton) {
        // implement save
        
        let disciplinaManager = DisciplinaManager.sharedInstance
     
        //Nova disciplina
        var newDisciplina = disciplinaManager.novaDisciplina()
        newDisciplina.nome = nameTextField.text!
        disciplinaManager.salvar()
        // --------------
        
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "newDisciplina", object: nil))
        
        //Alert with some message
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}