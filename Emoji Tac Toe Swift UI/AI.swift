//
//  AI.swift
//  Emoji Tac Toe Swift UI
//
//  Created by John Pavley on 10/9/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import SwiftUI

struct AI {
    
    @Binding var cellMap: [CellMarker]
    @Binding var currentTurn: CellMarker
    @State var difficulty = 0
    
    func takeTurn() {
        for i in 0..<cellMap.count {
            if cellMap[i] == .e {
                if difficulty == 0 {
                    cellMap[i] = currentTurn
                }
            }
        }
    }
}
