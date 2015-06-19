//
//  MasterViewController.swift
//  MultipleDetailViews
//
//  Code provided As Is, Do whatever you want with it, but do it at your own risk
//  www.SwiftWala.com
//

import UIKit

class MasterViewController: UITableViewController {
    
    let avaliacaoManager = AvaliacaoManager()
    var avaliacaoArray: Array<Avaliacao>!

    override func viewDidLoad() {
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        
        avaliacaoArray = avaliacaoManager.buscarAvaliacoes()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("update"), name: "newTrabalho", object: nil)
//        ///------ Teste CoreData ---------- OK ------
//        let disciplinaManager = DisciplinaManager.sharedInstance
//        let avaliacaoManager = AvaliacaoManager.sharedInstance
//        
//        //Nova disciplina
//        var newDisciplina = disciplinaManager.novaDisciplina()
//        newDisciplina.nome = "LP"
//        
//        var avaliacao = avaliacaoManager.novaAvaliacao()
//        avaliacao.nome = "Pbla"
//        avaliacao.nota = 8
//        avaliacaoManager.salvar()
//        
//        
//        newDisciplina.addAvaliacao(avaliacao)
//        
//        
//        let ss = avaliacaoManager.buscarAvaliacoes()[0].nome
//        let rr = avaliacaoManager.buscarAvaliacoes()[0].nota
//        println("\(ss) - \(rr)")
        
        
//        let ckh = CloudKitHelper()
//        ckh.syncToCoreData()
        
        //-------------------------------------------
    }
    func update(){
        avaliacaoArray = avaliacaoManager.buscarAvaliacoes()
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        
//        avaliacaoArray = avaliacaoManager.buscarAvaliacoes()
//        self.tableView.reloadData()
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: Selector("openMenu"))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.darkGrayColor()
    }
    
    func openMenu(){

        HKAppDelegate.mainDelegate().slideMenuVC.toggleMenu()
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
            return avaliacaoArray.count
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
            view.backgroundColor = UIColor.lightGrayColor()
            let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 150))
            imgView.image = UIImage(named: "redblur.jpeg")
            view.addSubview(imgView)
            let v = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 150))
            v.backgroundColor = UIColor.whiteColor()
            v.alpha = 0.3
            view.addSubview(v)
            
            var label = UILabel(frame: CGRect(x: self.view.bounds.width/2, y: view.bounds.height/2, width: self.view.bounds.width, height: 40))
            label.center = view.center
            label.text = "College Manager"
            label.textAlignment = NSTextAlignment.Center
            label.textColor = UIColor.darkGrayColor()
            view.addSubview(label)
            let imgView2 = UIImageView(frame: CGRect(x: self.view.bounds.width/2 + 70, y: 10, width: 30, height: 30))
            imgView2.center.y = view.center.y
            imgView2.image = UIImage(named: "CollegeIcon.png")
            view.addSubview(imgView2)
            return view
        }else{
            var view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50))
            view.backgroundColor = UIColor.lightGrayColor()
            var label = UILabel(frame: CGRect(x: self.view.bounds.width/2, y: 5, width: self.view.bounds.width, height: 40))
            let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50))
            imgView.image = UIImage(named: "redblur.jpeg")
            view.addSubview(imgView)
            let v = UIView(frame: CGRect(x: -2, y: 0, width: self.view.bounds.width + 10, height: 50))
            v.backgroundColor = UIColor.whiteColor()
            v.alpha = 0.8
            v.layer.borderColor = UIColor.redColor().CGColor

            v.layer.borderWidth = 0.6
             view.addSubview(v)
            label.center.x = view.center.x
            label.text = "Próximos eventos"
            
            label.textAlignment = NSTextAlignment.Center
            label.textColor = UIColor.darkGrayColor()
            view.addSubview(label)
            
            return view
        }
    }
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        self.tableView.reloadData()
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.textColor = UIColor.darkGrayColor()
        if indexPath.section == 0 {
            cell.textLabel?.text = "Matérias"
            cell.accessoryType = .DisclosureIndicator
        } else {
            
            var nome = avaliacaoArray[indexPath.item].nome
            // var dataF = String(avaliacaoArray[indexPath.item].dataFinal)     //Para exibir a data

            cell.textLabel?.text = nome //+ dataF
            
        }
        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0{
            self.performSegueWithIdentifier("showTableView2", sender: self)
        }else{
            var mainStoryboard = self.storyboard
            var vc = mainStoryboard!.instantiateViewControllerWithIdentifier("AvaliacaoController") as! AvaliacaoViewController
            
            vc.avaliacao = avaliacaoArray[indexPath.row]
            
//            if avaliacaoArray[indexPath.row].completo == 1{
//                vc.checked = true
//            }else{
//                vc.checked = false
//            }
            
            vc.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
            
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
    }
  
}

