//
//  SettingsTableViewController.swift
//  Ro-Sham-Bill
//
//  Created by Craig Larson on 4/27/18.
//  Copyright © 2018 Craig Larson. All rights reserved.
//

import UIKit
import CoreData
class SettingsTableViewController: UITableViewController {

    
    @IBOutlet weak var startNumberLabel: UILabel!
   
    @IBOutlet weak var endNumberLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Settings")
        
        
        var startNumber = 0
        var endNumber = 0
        //3
        do {
          let setting = try managedContext.fetch(fetchRequest).first
            if setting != nil {
                startNumber = setting!.value(forKey: "startNumber") as! Int
                endNumber = setting!.value(forKey: "endNumber") as! Int
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        startNumberLabel.text = "Start Number: \(startNumber)"
        endNumberLabel.text = "End Number: \(endNumber)"
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButtonClicked(_ sender: Any) {
        //TODO  Add save functionality
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Settings",
                                       in: managedContext)!
        
        let setting = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        setting.setValue( 1 , forKeyPath: "startNumber")
        setting.setValue(500, forKeyPath: "endNumber")
        
        // 4
        do {
            try managedContext.save()
        
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
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
        return 2
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
