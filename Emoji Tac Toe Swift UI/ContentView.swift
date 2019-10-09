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
    @State var singlePlayer = false
        
    var body: some View {
        VStack {
            // header
            Text("⭕️ vs. ❌").font(.largeTitle)
            Text("Score: \(score.oWins):\(score.xWins):\(score.ties)").font(.headline).padding()
            // row 0
            HStack {
                cellView(index: 0, currentTurn: $currentTurn, cellMap: $cellMap, score: $score)
                cellView(index: 1, currentTurn: $currentTurn, cellMap: $cellMap, score: $score)
                cellView(index: 2, currentTurn: $currentTurn, cellMap: $cellMap, score: $score)
            }
            // row 1
            HStack {
                cellView(index: 3, currentTurn: $currentTurn, cellMap: $cellMap, score: $score)
                cellView(index: 4, currentTurn: $currentTurn, cellMap: $cellMap, score: $score)
                cellView(index: 5, currentTurn: $currentTurn, cellMap: $cellMap, score: $score)
            }
            // row 2
            HStack {
                cellView(index: 6, currentTurn: $currentTurn, cellMap: $cellMap, score: $score)
                cellView(index: 7, currentTurn: $currentTurn, cellMap: $cellMap, score: $score)
                cellView(index: 8, currentTurn: $currentTurn, cellMap: $cellMap, score: $score)
            }
            // footer
            Text("\(currentTurn.rawValue)'s Turn").font(.headline).padding()
            HStack {
                Toggle(isOn: $singlePlayer) {
                    Text("")
                }.labelsHidden()
                Text("Play Againt AI")
            }
            Button(action: {
                // restart game
                self.currentTurn = .o
                self.cellMap = [.e,.e,.e,.e,.e,.e,.e,.e,.e]
            }) {
                Text("New Game")
            }.padding()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
