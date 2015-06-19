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
    
    
    var checked: Bool?
    var date: NSDate?
    var examName: String?
    var subjectName: String?
    var grade: Double?
    override func viewDidLoad() {
        
        if checked!{
            checkBoxOutlet.setAttributedTitle(NSAttributedString(string: "✓"), forState: UIControlState.Normal)
            gradeTextfield.enabled = true
            underlineLabel.hidden = false
            gradeTextfield.text = "\(grade!)"
            checked = true
            
        }else{
            checkBoxOutlet.setAttributedTitle(NSAttributedString(string: ""), forState: UIControlState.Normal)
            gradeTextfield.enabled = false
            underlineLabel.hidden = true
            checked = false
        }
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //format style. Browse online to get a format that fits your needs.
        
        dateLabel.text = dateFormatter.stringFromDate(date!)
        examNameTextField.text = examName
        subjectNameLabel.text = subjectName
        gradeTextfield.placeholder = "\(grade!)"
        
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
    
    
    @IBAction func didPressedDeleteButton(sender: AnyObject) {
        // implementar deletar
    }
    @IBAction func didPressedCancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func didPressedSaveButton(sender: UIButton) {
        //implementar a edicao com os dados novos
        
    }
   
    @IBAction func didPressedCheckButton(sender: UIButton) {
        if checked!{
            checkBoxOutlet.setAttributedTitle(NSAttributedString(string: ""), forState: UIControlState.Normal)
            gradeTextfield.enabled = false
            underlineLabel.hidden = true
            gradeTextfield.text = ""
            checked = false
        }else{
            checkBoxOutlet.setAttributedTitle(NSAttributedString(string: "✓"), forState: UIControlState.Normal)
            gradeTextfield.enabled = true
            underlineLabel.hidden = false
            gradeTextfield.text = "\(grade!)"
            checked = true
        }
    }
}