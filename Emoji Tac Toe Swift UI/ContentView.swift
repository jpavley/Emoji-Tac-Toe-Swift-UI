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
