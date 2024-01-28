//
//  MainView.swift
//  GuessTheDoodle
//
//  Created by Данік on 16/01/2024.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var matchManager: MatchManager
    
    var body: some View {
        VStack {
            Spacer()
            logo
            Spacer()
            playButton
            authenticationText
            Spacer()
        }
        .background(
            Image("menuBg")
                .resizable()
                .scaledToFill()
                .scaleEffect(1.2)
        )
        .ignoresSafeArea()
    }
    
    var logo: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .padding(30)
    }
    
    var playButton: some View {
        Button(action: {
            matchManager.startMatchMaking()
        }, label: {
            Text("PLAY")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
        }).disabled(matchManager.authenticationState != .authenticated || matchManager.inGame)
            .padding(.vertical, 20)
            .padding(.horizontal, 100)
            .background(
                Capsule(style: .circular)
                    .fill(matchManager.authenticationState != .authenticated || matchManager.inGame ? .gray : Color("playBtn"))
            )
    }
    
    var authenticationText: some View {
        Text(matchManager.authenticationState.rawValue)
            .font(.headline.weight(.semibold))
            .foregroundColor(Color("primaryYellow"))
            .padding()
    }
}

#Preview {
    MenuView(matchManager: MatchManager())
}
