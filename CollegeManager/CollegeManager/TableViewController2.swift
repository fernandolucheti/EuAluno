//
//  TableViewController2.swift
//  MultipleDetailViews
//
//  Code provided As Is, Do whatever you want with it, but do it at your own risk
//  www.SwiftWala.com
//

import UIKit

class TableViewController2: UITableViewController {
    
    let disciplinaManager = DisciplinaManager()
    var disciplinaArray: Array<Disciplina>!

    // MARK: - Table view data source
    
    override func viewDidLoad() {
        disciplinaArray = disciplinaManager.buscarDisciplinas()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return disciplinaArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        // Set appropriate labels for the cells.
        
        cell.textLabel?.text = disciplinaArray[indexPath.item].nome
        
        
        
//        if indexPath.row == 0 {
//            cell.textLabel?.text = "Cálculo 2"
//        }
//        else {
//            cell.textLabel?.text = "Engenharia de software 2"
//        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            DisciplinaSingleton.sharedInstance.nome = "Trabalho"
            self.performSegueWithIdentifier("showDetail1fromTableView2", sender: self)
        } else {
            self.performSegueWithIdentifier("showDetail2fromTableView2", sender: self)
        }
        
    }

    
    // MARK: - Navigation

       override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
        if segue.identifier == "showDetail1fr3omTableView2" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//            controller.navigationItem.leftItemsSupplementBackButton = true

            controller.view.backgroundColor = UIColor.purpleColor()
            
        } else if segue.identifier == "showDetail2fromTableView2" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController2
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
//            controller.view.backgroundColor = UIColor.orangeColor()
        }
        
        
    }
   

}
