//
//  Game.swift
//  Emoji Tac Toe Swift UI
//
//  Created by John Pavley on 10/9/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import SwiftUI

class Game {
    var cellMap: [CellMarker] = [.e,.e,.e,
                                        .e,.e,.e,
                                        .e,.e,.e]
    
    var currentTurn: CellMarker = .o
    var score = Score(xWins: 0, oWins: 0, ties: 0)
    var singlePlayer = false

}
