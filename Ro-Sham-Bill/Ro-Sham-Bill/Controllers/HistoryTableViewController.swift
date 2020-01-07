//
//  HistoryTableViewController.swift
//  Ro-Sham-Bill
//
//  Created by Craig Larson on 4/27/18.
//  Copyright © 2018 Craig Larson. All rights reserved.
//

import UIKit
import CoreData

class HistoryTableViewController: UITableViewController {

    // ----------------------------------
    var games:[NSManagedObject] = []
    var gameNumberToPass: Int!
    var gameToPass:NSManagedObject?
    // ----------------------------------
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Games")
        
        do {
        games = try context.fetch(fetchRequest)
        } catch let err as NSError {
            print("Could not retreive")
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return games.count == 0 ? 1 : games.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if games.count != 0 {
            
            // ---------------------------------------------
            self.gameNumberToPass = indexPath.row + 1
            self.gameToPass = games[indexPath.row]
            // ---------------------------------------------
            
            self.performSegue(withIdentifier: "goToHistoryDetailsScene", sender: self)
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameHistoryCellIdentifier", for: indexPath)
      
        let game = games[indexPath.row]
        
        // Configure the cell...
        cell.textLabel?.text = "Game \(indexPath.row + 1)"
        
 //       let playedOn = game.playedOn.addingTimeInterval(TimeInterval(indexPath.row * 300))
        let playedOn = game.value(forKeyPath: "playedOn") as! Date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        
        cell.detailTextLabel?.text = "\(dateFormatter.string(from: playedOn)) \(timeFormatter.string(from: playedOn))"
         
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextController = segue.destination as! HistoryDetailsTableViewController
        
        // ----------------------------------------
        
        nextController.gameNumber = self.gameNumberToPass!
        nextController.game = self.gameToPass!
      
        // ----------------------------------------
        
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
           // tableView.deleteRows(at: [indexPath], with: .fade)
            let game = self.games[indexPath.row]
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let context = appDelegate.persistentContainer.viewContext
            context.delete(game)
            do {
                try context.save()
                
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
                let context = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Games")
                
                do {
                    games = try context.fetch(fetchRequest)
                } catch let err as NSError {
                    print("Could not retreive")
                }
                self.tableView.reloadData()
            } catch let error as NSError {
                print("Error deleting \(error) ")
            }
        }
        
    }
    

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
