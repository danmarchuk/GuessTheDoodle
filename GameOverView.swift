//
//  GameOverView.swift
//  GuessTheDoodle
//
//  Created by Данік on 17/01/2024.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var matchManager: MatchManager
    
    var body: some View {
        VStack {
            Spacer()
            logo
            score
            Spacer()
            playButton
            Spacer()
        }
        .background(
            backgroundImage
        )
        .ignoresSafeArea()
    }
    
    var logo: some View {
        Image("gameOver")
            .resizable()
            .scaledToFit()
            .padding(30)
    }
    
    var score: some View {
        Text("Score: \(matchManager.score)")
            .font(.largeTitle)
            .bold()
            .foregroundColor(Color("primaryYellow"))
    }
    
    var playButton: some View {
        Button(action: {
            // TODO: Go back to menu
        }, label: {
            Text("MENU")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color("menuBtn"))
                .brightness(-0.4)
        }).disabled(matchManager.authenticationState != .authenticated || matchManager.inGame)
            .padding(.vertical, 20)
            .padding(.horizontal, 50)
            .background(
                Capsule(style: .circular)
                    .fill(Color("menuBtn"))
            )
    }
    
    var backgroundImage: some View {
        Image("gameOverBg")
            .resizable()
            .scaledToFill()
            .scaleEffect(1.2)
    }
}

#Preview {
    GameOverView(matchManager: MatchManager())
}
