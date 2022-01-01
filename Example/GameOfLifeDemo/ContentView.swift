//
//  ContentView.swift
//  GameOfLifeDemo
//
//  Created by Frederic FAUQUETTE on 01/01/2022.
//

import GameOfLife
import SwiftUI

struct ContentView: View {
    var body: some View {
        Game.create(rows: 30, columns: 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
