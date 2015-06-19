//
//  Avaliações Collection view.swift
//  CollegeManager
//
//  Created by Fernando Lucheti on 17/06/15.
//  Copyright (c) 2015 Fernando Lucheti. All rights reserved.
//

import Foundation

class AvaliacoesCollectionViewController: UICollectionViewController {
    var name: String?
    var avaliacoes: Array<Avaliacao>!
    override func viewDidLoad() {

        name = DisciplinaSingleton.sharedInstance.nome
        if name != nil{
            avaliacoes = DisciplinaManager.sharedInstance.getAvaliacoes(name!)
        }
    }
    func update(notification:NSNotification){
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if avaliacoes != nil{
           return avaliacoes.count
        }else{
            return 0
        }
        
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        var mainStoryboard = self.storyboard
        var vc = mainStoryboard!.instantiateViewControllerWithIdentifier("AvaliacaoController") as! AvaliacaoViewController
        
        vc.grade = Double(avaliacoes[indexPath.item].nota)
        vc.subjectName = avaliacoes[indexPath.item].disciplina.nome
        vc.examName = avaliacoes[indexPath.item].nome
        if avaliacoes[indexPath.item].completo == 1{
            vc.checked = true
        }else{
            vc.checked = false
        }
        vc.date = avaliacoes[indexPath.item].dataEntrega
        

        
        
        vc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! AvaliacaoCell
        if avaliacoes != nil{
            println()
           cell.nameLabel.text = avaliacoes[indexPath.row].nome

            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy" //format style. Browse online to get a format that fits your needs.
            cell.notaLabel.text = avaliacoes[indexPath.row].nota.stringValue
            cell.dataLabel.text =  dateFormatter.stringFromDate(avaliacoes[indexPath.row].dataEntrega)
        }
        
       // cell.layer.cornerRadius = 7
        cell.layer.borderWidth = 0.6
        cell.layer.borderColor = UIColor.orangeColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(1, 1)
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowRadius = 2
        cell.layer.shadowOpacity = 0.6
        cell.clipsToBounds = false
        
        return cell
    }
}