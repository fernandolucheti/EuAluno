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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationBar.backItem?.title = "voltar"
    }
    @IBAction func didPressSaveButton(sender: UIBarButtonItem) {
        //implement save methods
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func didPressBackButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}