//
//  ContentView.swift
//  Emoji Tac Toe Swift UI
//
//  Created by John Pavley on 10/7/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import SwiftUI

enum CellMarker: String {
    case e = "❔"
    case x = "❌"
    case o = "⭕️"
}

struct ContentView: View {
    
    @State var cellMap: [CellMarker] = [.e,.e,.e,
                                        .e,.e,.e,
                                        .e,.e,.e]
    
    @State var currentTurn: CellMarker = .o
    
    var body: some View {
        VStack {
            // header
            Text("❌ vs. ⭕️").font(.largeTitle)
            Text("Score: 1:2:3").font(.headline).padding()
            // row 0
            HStack {
                cellView(index: 0, currentTurn: $currentTurn, cellMap: $cellMap)
                cellView(index: 1, currentTurn: $currentTurn, cellMap: $cellMap)
                cellView(index: 2, currentTurn: $currentTurn, cellMap: $cellMap)
            }
            // row 1
            HStack {
                cellView(index: 3, currentTurn: $currentTurn, cellMap: $cellMap)
                cellView(index: 4, currentTurn: $currentTurn, cellMap: $cellMap)
                cellView(index: 5, currentTurn: $currentTurn, cellMap: $cellMap)
            }
            // row 2
            HStack {
                cellView(index: 6, currentTurn: $currentTurn, cellMap: $cellMap)
                cellView(index: 7, currentTurn: $currentTurn, cellMap: $cellMap)
                cellView(index: 8, currentTurn: $currentTurn, cellMap: $cellMap)
            }
            // footer
            Text("\(currentTurn.rawValue)'s Turn").font(.headline)
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct cellView: View {
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
    
    @State var showAlert = false
    @State var alertTitle = ""
    
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
            alertTitle = "\(currentTurn.rawValue) Wins 😎"
            showAlert = true
        }
        if openCellCount() == 0 {
            alertTitle = "Nobody Wins 😖"
            showAlert = true
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
