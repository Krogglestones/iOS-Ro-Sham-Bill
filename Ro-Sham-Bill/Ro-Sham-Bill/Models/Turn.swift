//
//  Turn.swift
//  Ro-Sham-Bill
//
//  Created by Craig Larson on 5/1/18.
//  Copyright © 2018 Craig Larson. All rights reserved.
//

import Foundation

class Turn {
    
    var guessOn:Date
    var playerName:String
    var playerGuess:Int
    
    init(guessOn:Date, playerName:String, playerGuess:Int) {
        self.guessOn = guessOn
        self.playerName = playerName
        self.playerGuess = playerGuess
        
    }
    
}

