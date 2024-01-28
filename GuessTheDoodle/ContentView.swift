//
//  ContentView.swift
//  GuessTheDoodle
//
//  Created by Данік on 16/01/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var matchManager = MatchManager()
    var body: some View {
        ZStack {
            if matchManager.isGameOver {
                GameView(matchManager: matchManager)
            } else if matchManager.inGame {
                GameView(matchManager: matchManager)
            } else {
                MenuView(matchManager: matchManager)
            }
        }
        .onAppear {
            matchManager.authenticateUser()
        }
    }
}

#Preview {
    ContentView()
}
