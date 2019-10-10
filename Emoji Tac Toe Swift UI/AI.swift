//
//  AI.swift
//  Emoji Tac Toe Swift UI
//
//  Created by John Pavley on 10/9/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import SwiftUI

struct AI {
    
    static let winningVectors = [
        [0,1,2], // row 0
        [3,4,5], // row 1
        [6,7,8], // row 2
        
        [0,3,6], // col 0
        [1,4,7], // col 1
        [2,5,8], // col 2
        
        [0,4,8], // dia 0
        [2,4,6]  // dia 1
    ]
    
    enum Difficulty: Int {
        case easy = 0, medium, hard
    }
    
    @Binding var cellMap: [CellMarker]
    @Binding var currentTurn: CellMarker
    
    var difficulty = Difficulty.easy
    
    func takeTurn() {
        switch difficulty {
        case .easy:
            doEasy()
        case .medium:
            doMedium()
        case .hard:
            doHard()
        }
    }
    
    func doEasy() {
        // mark the first open cell
        for i in 0..<cellMap.count {
            if cellMap[i] == .e {
                cellMap[i] = currentTurn
                break
            }
        }
    }
    
    func doMedium() {
        // mark a random cell
        var openIndexes = [Int]()
        for i in 0..<cellMap.count {
            if cellMap[i] == .e {
                openIndexes.append(i)
            }
        }
        let randomIndex = openIndexes.randomElement()
        cellMap[randomIndex!] = currentTurn
    }
    
    func doHard() {
        
        func winningMove(_ index: Int) -> Bool {
            
            func copyCellMap() -> [CellMarker] {
                var result = [CellMarker]()
                
                // make a deep copy so it's a different object
                for m in cellMap {
                    result.append(m)
                }
                return  result
            }
            
            func winner() -> Bool {
                
                var cellMapCopy = copyCellMap()
                
                // make the proposed change
                cellMapCopy[index] = .x
                    
                // search for a winning vector
                for v in AI.winningVectors {
                    if cellMap[v[0]] != .e && cellMap[v[1]] != .e && cellMap[v[2]] != .e {
                        if cellMap[v[0]] == cellMap[v[1]] && cellMap[v[1]] == cellMap[v[2]] {
                            
                            print("\(v[0]): \(cellMap[v[0]]), \(v[1]): \(cellMap[v[1]]), \(v[2]): \(cellMap[v[2]])")
                            
                            // found a winning vector with the proposed move
                            return true
                        }
                    }
                }
                
                // didn't find a winning vector
                return false
            }
            return false
        }
        
        func blockingMove(_ index: Int) -> Bool {
            return false
        }
        
        var foundMove = false
        for i in 0..<cellMap.count {
            if cellMap[i] == .e {
                if winningMove(i) {
                    cellMap[i] = currentTurn
                    foundMove = true
                } else if blockingMove(i) {
                    cellMap[i] = currentTurn
                    foundMove = true
                }
            }
        }
        if !foundMove {
            doMedium()
        }
    }
}
