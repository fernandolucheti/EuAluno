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
    var checked = false
    override func viewDidLoad() {
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
    }
    @IBAction func didPressedCancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func didPressedSaveButton(sender: UIButton) {
    }
   
    @IBAction func didPressedCheckButton(sender: UIButton) {
        if checked{
            checkBoxOutlet.setAttributedTitle(NSAttributedString(string: ""), forState: UIControlState.Normal)
            checked = false
        }else{
            checkBoxOutlet.setAttributedTitle(NSAttributedString(string: "✓"), forState: UIControlState.Normal)
            checked = true
        }
    }
}