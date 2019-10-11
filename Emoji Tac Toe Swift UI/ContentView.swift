//
//  ContentView.swift
//  Emoji Tac Toe Swift UI
//
//  Created by John Pavley on 10/7/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import SwiftUI

struct ContentView: View {
        
    @State var cellMap: [CellMarker] = [.e,.e,.e,
                                        .e,.e,.e,
                                        .e,.e,.e]
    
    @State var currentTurn: CellMarker = .o
    @State var score = Score(xWins: 0, oWins: 0, ties: 0)
    
    @State var playWithAI: Bool = false {
        didSet {
            // TODO: Why is this not called when set?
            restartGame()
        }
    }
        
    var body: some View {
        VStack {
            // header
            Text("⭕️ vs. ❌").font(.largeTitle)
            Text("Score: \(score.oWins):\(score.xWins):\(score.ties)").font(.headline).padding()
            // row 0
            HStack {
                makeCellView(index: 0)
                makeCellView(index: 1)
                makeCellView(index: 2)
            }
            // row 1
            HStack {
                makeCellView(index: 3)
                makeCellView(index: 4)
                makeCellView(index: 5)
            }
            // row 2
            HStack {
                makeCellView(index: 6)
                makeCellView(index: 7)
                makeCellView(index: 8)
            }
            // footer
            Text("\(currentTurn.rawValue)'s Turn").font(.headline).padding()
            HStack {
                Toggle(isOn: $playWithAI) {
                    Text("")
                }.labelsHidden()
                Text("Play with AI")
            }
            Button(action: {
                self.restartGame()
            }) {
                Text("New Game")
            }.padding()
        }.padding()
    }
    
    func restartGame() {
        currentTurn = .o
        cellMap = [.e,.e,.e,.e,.e,.e,.e,.e,.e]
    }
    
    func makeCellView(index: Int) -> CellView {
        return CellView(index: index, currentTurn: $currentTurn, cellMap: $cellMap, score: $score, playWithAI: $playWithAI)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
