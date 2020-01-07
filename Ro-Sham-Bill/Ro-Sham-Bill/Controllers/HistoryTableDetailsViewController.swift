//
//  HistoryDetailsTableViewController.swift
//  Ro-Sham-Bill
//
//  Created by Craig Larson on 4/27/18.
//  Copyright © 2018 Craig Larson. All rights reserved.
//

import UIKit
import CoreData

class HistoryDetailsTableViewController: UITableViewController {
   
    var gameNumber = Int()
 //   var theGameThatWasPassed: Game!;
    var game:NSManagedObject!
    var turns:[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
          //  print(theGameThatWasPassed)
     //       print(theGameThatWasPassed.turns.count)
        self.turns = (game!.value(forKeyPath: "turns") as? NSSet)?.allObjects as! [NSManagedObject]
        
        self.turns = self.turns.sorted {
            ($0.value(forKeyPath: "guessOn") as! Date) < ($1.value(forKeyPath: "guessOn") as! Date)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 {
            return 6
        } else {
            return turns.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0){
        let cell = tableView.dequeueReusableCell(withIdentifier: "testIdentifier", for: indexPath)
            if indexPath.row == 0 {
                cell.textLabel?.text = "Game Number"
                cell.detailTextLabel?.text = String(gameNumber)
                
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "Time"
                
                let playedOn = game.value(forKeyPath: "playedOn") as! Date
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short
                
                let timeFormatter = DateFormatter()
                timeFormatter.timeStyle = .short
                
                cell.detailTextLabel?.text = "\(dateFormatter.string(from: playedOn)) \(timeFormatter.string(from: playedOn))"
                
            } else if indexPath.row == 2 {
                cell.textLabel?.text = "Server's Number"
                cell.detailTextLabel?.text = "\(game.value(forKeyPath: "numberPicked")!)"
                
            } else if indexPath.row == 3 {
                cell.textLabel?.text = "Number of Players"
                let numberOfPlayers = game!.value(forKeyPath: "numberOfPlayers") as! Int
                cell.detailTextLabel?.text = numberOfPlayers == 0 ? "--" : "\(numberOfPlayers)"
                
            } else if indexPath.row == 4 {
                cell.textLabel?.text = "Number of Turns"
                      cell.detailTextLabel?.text = "\(turns.count)"
                
            } else {
                cell.textLabel?.text = "Winner"
                let winner = turns.last?.value(forKeyPath: "playerName")
                cell.detailTextLabel?.text = winner as! String
            }
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "turnIdentifier", for: indexPath)
            
            let turn = self.turns[indexPath.row]
            let playerName = turn.value(forKeyPath: "playerName") as! String
            let playerGuess = turn.value(forKeyPath: "playerGuess") as! Int
            
            cell.textLabel?.text = "Turn \(indexPath.row + 1): \(playerName) guessed \(playerGuess)"
            return cell
        }
    }
            
            
            /*
     
            
        } else if indexPath.section == 1 {
            
           
      //      cell.textLabel?.text = "Turn \(indexPath.row + 1):  \(theGameThatWasPassed.turns[indexPath.row].playerName) guessed \(theGameThatWasPassed.turns[indexPath.row].playerGuess)"
            
        }

        return cell
    }
    */
    // -------------------------
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "General"
        }
        return "Turns"
    }

    // -------------------------
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
