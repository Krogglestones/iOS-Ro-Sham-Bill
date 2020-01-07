//
//  WinnerViewController.swift
//  Ro-Sham-Bill
//
//  Created by Craig Larson on 4/27/18.
//  Copyright © 2018 Craig Larson. All rights reserved.
//

import UIKit
import CoreData

class WinnerViewController: UIViewController {

    var game:Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Save data here
        // --------------
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Games",
                                       in: managedContext)!
        
        let theGame = NSManagedObject(entity: entity,
                                      insertInto: managedContext)
        
        // 3
        theGame.setValue( game.startNumber , forKeyPath: "startNumber")
        theGame.setValue( game.endNumber , forKeyPath: "endNumber")
        theGame.setValue( game.numberOfPlayers , forKeyPath: "numberOfPlayers")
        theGame.setValue( game.numberPicked , forKeyPath: "numberPicked")
        theGame.setValue( game.playedOn , forKeyPath: "playedOn")
        
        for turn in game.turns {
            let turnEntity = NSEntityDescription.entity(forEntityName: "Turns", in: managedContext)!
            
            
            let turnToAdd = NSManagedObject(entity: turnEntity, insertInto: managedContext)
            
            turnToAdd.setValue(turn.guessOn, forKeyPath: "guessOn")
            turnToAdd.setValue(turn.playerGuess, forKey: "playerGuess")
            turnToAdd.setValue(turn.playerName, forKey: "playerName")
            
            theGame.mutableSetValue(forKeyPath: "turns").add(turnToAdd)
        }
        
        // 4
        do {
            try managedContext.save()
            print("GAME SAVED!!!")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func homeButtonClicked(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
