//
//  GuessViewController.swift
//  Ro-Sham-Bill
//
//  Created by Craig Larson on 4/27/18.
//  Copyright © 2018 Craig Larson. All rights reserved.
//

import UIKit
import CoreData


class GuessViewController: UIViewController {

    var game:Game!
    var playerNumber = 1
    var minGuess = 0
    var maxGuess = 0
    
    @IBOutlet weak var guessLabel: UILabel!
    
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var playerLabel: UILabel!
    
    
    @IBOutlet weak var instructionsLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playerLabel.text = "Player \(playerNumber)"
        var instructionsTruple = BaseController.getInstructions(startNumber: nil, endNumber: nil)
        minGuess = instructionsTruple.startNumber
        maxGuess = instructionsTruple.endNumber
        instructionsLabel.attributedText = instructionsTruple.message
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func okButtonClicked(_ sender: Any) {
        
        guard let guessNumberString = guessTextField.text,
            let guessNumber = Int(guessNumberString) else {
                return
        }
        
        if (game.numberPicked > guessNumber) {
            // higher
            guessLabel.text = "Higher"
            guessLabel.textColor = UIColor(displayP3Red: 0.56, green: 0.75, blue: 0.0, alpha: 1.0)
            minGuess = guessNumber
        } else if (game.numberPicked < guessNumber) {
            // lower
            guessLabel.text = "Lower"
            guessLabel.textColor = UIColor(displayP3Red: 0.00, green: 0.78, blue: 0.78, alpha: 1.0)
            maxGuess = guessNumber
        } else {
            // winner
            game.turns.append(Turn(guessOn: Date(), playerName: playerLabel.text!, playerGuess: guessNumber))

            self.performSegue(withIdentifier: "goToWinnersSegue", sender: self)
            return
        }
        
        game.turns.append(Turn(guessOn: Date(), playerName: playerLabel.text!, playerGuess: guessNumber))

        playerNumber = playerNumber >= game.numberOfPlayers ? 1 : playerNumber + 1
        playerLabel.text = "Player \(playerNumber)"
        guessTextField.text = ""
        instructionsLabel.attributedText = BaseController.getInstructions(startNumber: minGuess, endNumber: maxGuess).message
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let winnerController = segue.destination as! WinnerViewController
        winnerController.game = game
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    */

}
