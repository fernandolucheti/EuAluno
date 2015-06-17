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
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var disciplinaTextField: UITextField!
    override func viewDidLoad() {
//        super.viewDidLoad()
//        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"b"];
        

        //self.view.backgroundColor = UIColor.whiteColor()
       // self.navigationBar.backItem?.title = "voltar"
    }
    
    @IBAction func CancelButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func SaveButton(sender: UIButton) {
        // implement save
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}