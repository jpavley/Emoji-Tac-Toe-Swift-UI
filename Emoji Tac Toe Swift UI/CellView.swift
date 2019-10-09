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
    
    let winningVectors = [
        [0,1,2], // row 0
        [3,4,5], // row 1
        [6,7,8], // row 2
        
        [0,3,6], // col 0
        [1,4,7], // col 1
        [2,5,8], // col 2
        
        [0,4,8], // dia 0
        [2,4,6]  // dia 1
    ]
    
    @Binding var currentTurn: CellMarker
    @Binding var cellMap: [CellMarker]
    @Binding var score: Score
    
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
            alertTitle = "\(winningMarker.rawValue) Wins 😎"
            updateScore()
            showAlert = true
        } else if openCellCount() == 0 {
            winningMarker = .e
            alertTitle = "Nobody Wins 😖"
            updateScore()
            showAlert = true
        }
        

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
    
    func winner() -> Bool {
                
        for v in winningVectors {
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
    
    func openCellCount() -> Int {
        return cellMap.filter{ $0 == .e }.count
    }
}

