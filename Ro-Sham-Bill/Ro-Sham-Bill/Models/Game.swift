//
//  Game.swift
//  Ro-Sham-Bill
//
//  Created by Craig Larson on 5/1/18.
//  Copyright © 2018 Craig Larson. All rights reserved.
//

import Foundation

class Game {
    
    var numberOfPlayers: Int
    var startNumber: Int
    var endNumber: Int
    var numberPicked:Int
    var playedOn: Date
    
    var turns:[Turn]
    
    init(numberOfPlayers:Int, startNumber:Int, endNumber:Int, numberPicked:Int, playedOn:Date, turns:[Turn]) {
        self.numberOfPlayers = numberOfPlayers
        self.startNumber = startNumber
        self.endNumber = endNumber
        self.numberPicked = numberPicked
        self.playedOn = playedOn
        
        self.turns = turns
    }
    
}

