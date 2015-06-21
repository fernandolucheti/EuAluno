//
//  AvaliacaoViewController.swift
//  CollegeManager
//
//  Created by Fernando Lucheti on 18/06/15.
//  Copyright (c) 2015 Fernando Lucheti. All rights reserved.
//

import Foundation

class AvaliacaoViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var examNameTextField: UITextField!
    @IBOutlet weak var subjectNameLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var checkBoxOutlet: UIButton!
    @IBOutlet weak var gradeTextfield: UITextField!
    
    @IBOutlet weak var underlineLabel: UILabel!
    
    
//    var checked: Bool?
    var avaliacao: Avaliacao?
    
    
    override func viewDidLoad() {
        
        if avaliacao?.completo == 1{
            checkBoxOutlet.setAttributedTitle(NSAttributedString(string: "✓"), forState: UIControlState.Normal)
            gradeTextfield.enabled = true
            
            underlineLabel.hidden = false
            gradeTextfield.text = "\(Double(avaliacao!.nota))"
//            checked = true
            
        }else{
            checkBoxOutlet.setAttributedTitle(NSAttributedString(string: ""), forState: UIControlState.Normal)
            gradeTextfield.enabled = false
            underlineLabel.hidden = true
//            checked = false
        }
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //format style. Browse online to get a format that fits your needs.
        
        dateLabel.text = dateFormatter.stringFromDate(avaliacao!.dataEntrega)
        examNameTextField.text = avaliacao?.nome
        subjectNameLabel.text = avaliacao?.disciplina.nome
        gradeTextfield.placeholder = "\(Double(avaliacao!.nota))"
        
        checkBoxOutlet.layer.cornerRadius = 6
        checkBoxOutlet.layer.borderColor = UIColor.blackColor().CGColor
        checkBoxOutlet.layer.borderWidth = 0.8
        //checkBoxOutlet.backgroundColor = UIColor.whiteColor()
    }
    
    @IBAction func backButton(sender: UIButton) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        gradeTextfield.resignFirstResponder()
        examNameTextField.resignFirstResponder()
    }
    
    /// implementacao do deletar
    @IBAction func didPressedDeleteButton(sender: AnyObject) {

        let am = AvaliacaoManager()
        am.avaliacao = avaliacao
        am.apagar()
        
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "newTrabalho", object: nil))
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didPressedCancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /// Implementacao da edicao com os dados novos
    @IBAction func didPressedSaveButton(sender: UIButton) {
        //implementar a edicao com os dados novos

        // Remove event notifications.
        if checked == true {
            // TODO: Add missing event (Avaliacao) argument.
            // NotificationController.removeReminder()
        }
        
        avaliacao?.nome = examNameTextField.text
        // o completo é modificado quando clica
        avaliacao!.nota = NSNumber(double: (gradeTextfield.text as NSString).doubleValue)
        
        let am = AvaliacaoManager()
        am.avaliacao = avaliacao
        am.salvar()
        
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "newTrabalho", object: nil))
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
    @IBAction func didPressedCheckButton(sender: UIButton) {
        if avaliacao!.completo == 1{
            checkBoxOutlet.setAttributedTitle(NSAttributedString(string: ""), forState: UIControlState.Normal)
            gradeTextfield.enabled = false
            underlineLabel.hidden = true
            gradeTextfield.text = ""
            avaliacao?.completo = 0
//            checked = false
        }else{
            checkBoxOutlet.setAttributedTitle(NSAttributedString(string: "✓"), forState: UIControlState.Normal)
            gradeTextfield.enabled = true
            underlineLabel.hidden = false
            gradeTextfield.text = "\(Double(avaliacao!.nota))"
            avaliacao?.completo = 1
//            checked = true
        }
    }
    
}