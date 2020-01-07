//
//  BaseController.swift
//  Ro-Sham-Bill
//
//  Created by Craig Larson on 5/17/18.
//  Copyright © 2018 Craig Larson. All rights reserved.
//

import UIKit
import CoreData

class BaseController {
    
    static func getInstructions(startNumber:Int?, endNumber:Int?) -> (startNumber:Int, endNumber:Int, message:NSMutableAttributedString, isError:Bool) {
        
        var instructionsTruple = (startNumber:1, endNumber:1000, message:NSMutableAttributedString(string: ""), isError:false)
        
        if let startNumber = startNumber,
            let endNumber = endNumber {
            instructionsTruple.startNumber = startNumber
            instructionsTruple.endNumber = endNumber
        } else {
        
        // 1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            
            //TODO: Display error msg
            instructionsTruple.isError = true
            instructionsTruple.message = NSMutableAttributedString(string: "Error")
            return instructionsTruple
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Settings")
        
        //3
        do {
            let setting = try managedContext.fetch(fetchRequest).first
            if setting != nil {
                instructionsTruple.startNumber = setting!.value(forKey: "startNumber") as! Int
                instructionsTruple.endNumber = setting!.value(forKey: "endNumber") as! Int
            }
        } catch let error as NSError {
           // return NSMutableAttributedString(string: "Error")
            
            instructionsTruple.isError = true
            instructionsTruple.message = NSMutableAttributedString(string: "Error")
            return instructionsTruple
            }
        }
        
        // --------------------------------------------
        
        let boldStyling = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)]
        
        let instructionString = NSMutableAttributedString(string: "Enter a number between ")
        let startNumberString = NSMutableAttributedString(string: String(instructionsTruple.startNumber), attributes: boldStyling)
        let andString = NSMutableAttributedString(string: " and ")
        let endNumberString = NSMutableAttributedString(string: String(instructionsTruple.endNumber), attributes: boldStyling)
        
        instructionString.append(startNumberString)
        instructionString.append(andString)
        instructionString.append(endNumberString)
        
        instructionsTruple.message = instructionString
        instructionsTruple.isError = false
        
        return instructionsTruple
    }
    
}
