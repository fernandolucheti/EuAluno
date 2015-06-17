//
//  MasterViewController.swift
//  MultipleDetailViews
//
//  Code provided As Is, Do whatever you want with it, but do it at your own risk
//  www.SwiftWala.com
//

import UIKit

class MasterViewController: UITableViewController {
    

    override func viewDidLoad() {
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        
        ///------ Teste CoreData ---------- OK ------
        let disciplinaManager = DisciplinaManager.sharedInstance
        let avaliacaoManager = AvaliacaoManager.sharedInstance
        
        //Nova disciplina
        var newDisciplina = disciplinaManager.novaDisciplina()
        newDisciplina.nome = "LP"
        
        var avaliacao = avaliacaoManager.novaAvaliacao()
        avaliacao.nome = "Pbla"
        avaliacao.nota = 8
        avaliacaoManager.salvar()
        
        
        newDisciplina.addAvaliacao(avaliacao)
        
        
        let ss = avaliacaoManager.buscarAvaliacoes()[0].nome
        let rr = avaliacaoManager.buscarAvaliacoes()[0].nota
        println("\(ss) - \(rr)")
        
        
//        let ckh = CloudKitHelper()
//        ckh.saveTodo("blá blá 22")
        
        
        
        
        //-------------------------------------------
        
        
        
        
    }
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail1" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if segue.identifier == "showDetail2" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController2
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return 3
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat(150)
        }else{
            return CGFloat(50)
        }
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "x"
        case 1:
            return "x"
        default:
            return ""
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            var view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 150))
            view.backgroundColor = UIColor.grayColor()
            var label = UILabel(frame: CGRect(x: self.view.bounds.width/2, y: view.bounds.height/2, width: self.view.bounds.width, height: 40))
            label.center = view.center
            label.text = "College Manager"
            label.textAlignment = NSTextAlignment.Center
            label.textColor = UIColor.whiteColor()
            view.addSubview(label)
            return view
        }else{
            var view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50))
            view.backgroundColor = UIColor.grayColor()
            var label = UILabel(frame: CGRect(x: self.view.bounds.width/2, y: 5, width: self.view.bounds.width, height: 40))
            label.center.x = view.center.x
            label.text = "Próximos eventos"
            label.textAlignment = NSTextAlignment.Center
            label.textColor = UIColor.whiteColor()
            view.addSubview(label)
            return view
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        
        if indexPath.section == 0{
            cell.textLabel?.text = "Matérias"
            cell.accessoryType = .DisclosureIndicator
        }else{
            // Set appropriate labels for the cells.
            if indexPath.row == 0 {
                cell.textLabel?.text = "Prova APD3"
            }
            else if indexPath.row == 1 {
                cell.textLabel?.text = "Lista de Cálculo"
            }
            else {
                cell.textLabel?.text = "Projeto Mobile"
                
            }
        }
        
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0{
            self.performSegueWithIdentifier("showTableView2", sender: self)
        }else{
            self.performSegueWithIdentifier("showDetail1", sender: self)
        }
        
    }
  
}

