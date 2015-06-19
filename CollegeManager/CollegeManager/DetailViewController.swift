//
//  DetailViewController.swift
//  MultipleDetailViews
//
//  Code provided As Is, Do whatever you want with it, but do it at your own risk
//  www.SwiftWala.com
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: AnyObject? {
        didSet {
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.

        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {

        if (UIScreen.mainScreen().bounds.height < 737){
        if HKAppDelegate.mainDelegate().isFirstAccess{
            var view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
            view.backgroundColor = UIColor.whiteColor()
            self.view.addSubview(view)
        }
        }
        self.title = DisciplinaSingleton.sharedInstance.nome
    }
    override func viewDidAppear(animated: Bool) {
        if (UIScreen.mainScreen().bounds.height < 737){
        if HKAppDelegate.mainDelegate().isFirstAccess{
            HKAppDelegate.mainDelegate().isFirstAccess = false
            var mainStoryboard = self.storyboard
            var vc = mainStoryboard!.instantiateViewControllerWithIdentifier("Master") as! UIViewController

            self.showViewController(vc, sender: self)
            }}
        
    }
    override func viewDidLoad() {
        //super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        //self.configureView()
    }

    @IBAction func didPressedBackButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

