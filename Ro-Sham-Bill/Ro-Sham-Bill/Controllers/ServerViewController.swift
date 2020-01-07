//
//  ServerViewController.swift
//  Ro-Sham-Bill
//
//  Created by Craig Larson on 4/27/18.
//  Copyright © 2018 Craig Larson. All rights reserved.
//

import UIKit
import CoreData

class ServerViewController: UIViewController {
    
    var game:Game?
    
  
    @IBOutlet weak var serverNumberTextField: UITextField!
    
    
    @IBOutlet weak var instructionsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        var instructionsTruple = BaseController.getInstructions(startNumber: nil, endNumber: nil)
        
        self.game = Game(numberOfPlayers: 0, startNumber: 1, endNumber: 1000, numberPicked: 0, playedOn: Date(), turns: [])
        
        instructionsLabel.attributedText = instructionsTruple.message
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okButtonClicked(_ sender: Any) {
        
        guard let serverNumberString = serverNumberTextField.text,
            let serverNumber = Int(serverNumberString) else {
                return
        }
        
        game!.numberPicked = serverNumber
        
        self.performSegue(withIdentifier: "goToPlayersSegue", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let playerController = segue.destination as! PlayersViewController
        playerController.game = game

    }
    

}
