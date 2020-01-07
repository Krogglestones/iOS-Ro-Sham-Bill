//
//  PlayersViewController.swift
//  Ro-Sham-Bill
//
//  Created by Craig Larson on 4/27/18.
//  Copyright © 2018 Craig Larson. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {
    
    var game:Game!
    
    @IBOutlet weak var numberOfPlayersTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func okButtonClicked(_ sender: Any) {
        
        guard let numberOfPlayersString = numberOfPlayersTextField.text,
            let numberOfPlayers = Int(numberOfPlayersString) else {
                print("Error Message")
                return
        }
        game.numberOfPlayers = numberOfPlayers
        
        self.performSegue(withIdentifier: "goToGuessSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let guessController = segue.destination as! GuessViewController
        guessController.game = game
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    */

}
