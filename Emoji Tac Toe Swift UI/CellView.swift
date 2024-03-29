//
//  CellView.swift
//  Emoji Tac Toe Swift UI
//
//  Created by John Pavley on 10/9/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import SwiftUI

struct CellView: View {
    let index: Int
        
    @Binding var currentTurn: CellMarker
    @Binding var cellMap: [CellMarker]
    @Binding var score: Score
    @Binding var playWithAI: Bool
    @Binding var difficulty: Double
    
    @State var showAlert = false
    @State var alertTitle = ""
    @State var winningMarker = CellMarker.e
        
    var body: some View {
        Button(action: {
            self.doTap()
        }) {
            Text(self.cellMap[self.index].rawValue)
            .font(.largeTitle)
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle),
                  message: Text("Play Again?"),
                  primaryButton: Alert.Button.destructive(Text("Yes")) {
                    // restart game
                    self.currentTurn = .o
                    self.cellMap = [.e,.e,.e,.e,.e,.e,.e,.e,.e]
                },
                  secondaryButton: .cancel(Text("No")) {
                    // nothing to do!
                }
            )
        }
    }
    
    func doTap() {
        update()
        if winner() {
            doWinner()
        } else if noMoveAvailable() {
            doNoMove()
        } else if aiTakeTurn() {
            doAI()
            if winner() {
                doWinner()
            } else if noMoveAvailable() {
                doNoMove()
            }
        }
    }
    
    func doWinner() {
                
        let winnerEmoji = winningMarker == .o ? "😇" : "😈"
        alertTitle = "\(winningMarker.rawValue) Wins \(winnerEmoji)"
        updateScore()
        showAlert = true
    }
    
    func doNoMove() {
        winningMarker = .e
        alertTitle = "Nobody Wins 🤡"
        updateScore()
        showAlert = true
    }
    
    func doAI() {
        let ai = AI(cellMap: $cellMap, currentTurn: $currentTurn, difficulty: $difficulty)
        ai.takeTurn()
        currentTurn = .o
    }
    
    func updateScore() {
        switch winningMarker {
        case .o:
            score.oWins += 1
        case .x:
            score.xWins += 1
        case .e:
            score.ties += 1
        }
    }
    
    func update() {
        if cellMap[index] == .e {
            cellMap[index] = currentTurn
            if currentTurn == .o {
                currentTurn = .x
            } else {
                currentTurn = .o
            }
        }
    }
    
    func aiTakeTurn() -> Bool {
        return playWithAI && (currentTurn == .x)
    }
        
    func noMoveAvailable() -> Bool {
        return cellMap.filter{ $0 == .e }.count == 0
    }
    
    func winner() -> Bool {
                
        for v in AI.winningVectors {
            if cellMap[v[0]] != .e && cellMap[v[1]] != .e && cellMap[v[2]] != .e {
                if cellMap[v[0]] == cellMap[v[1]] && cellMap[v[1]] == cellMap[v[2]] {
                    
                    print("\(v[0]): \(cellMap[v[0]]), \(v[1]): \(cellMap[v[1]]), \(v[2]): \(cellMap[v[2]])")
                    
                    winningMarker = cellMap[v[0]]
                                        
                    return true
                }
            }
        }
        return false
    }
}

