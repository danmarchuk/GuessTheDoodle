//
//  GameView.swift
//  GuessTheDoodle
//
//  Created by Данік on 17/01/2024.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var matchManager: MatchManager
    @State var drawingGuess = ""
    @State var eraserEnabled = false
    
    func makeGuess () {
        // TODO: Submit the guess
        
    }
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                Image(matchManager.currentlyDrawing ? "drawerBg": "guesserBg")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .scaleEffect(1.1)
                
                VStack {
                    topBar
                    drawingBar
                    pastGuesses
                }
                
                .padding(.horizontal, 30)
                .ignoresSafeArea(.keyboard, edges: .bottom )
            }
            VStack {
                Spacer()
                promptGroup
            }
            .ignoresSafeArea(.container)
            
        }
    }
    
    var topBar: some View {
        VStack {
            HStack {
                
                Button {
                    // TODO: disconect from the game
                } label: {
                    Image(systemName: "arrowshape.turn.up.left.circle.fill")
                        .font(.largeTitle)
                        .tint(Color(matchManager.currentlyDrawing ? "primaryYellow": "primaryPurple"))
                }
                
                Spacer()
                
                Label("\(matchManager.remainingTime)",
                      systemImage: "clock.fill")
                .bold()
                .font(.title2)
                .foregroundColor(Color(matchManager.currentlyDrawing ? "primaryYellow": "primaryPurple"))
            }
            
        }
        .padding(.vertical, 15)
    }
    
    var drawingBar: some View {
        ZStack {
            DrawingView(matchManager: matchManager, eraserEnabled: $eraserEnabled)
                .aspectRatio(1, contentMode: .fit)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 10)
                )
            
            VStack {
                HStack {
                    Spacer()
                    if matchManager.currentlyDrawing {
                        Button {
                            eraserEnabled.toggle()
                        } label: {
                            Image(systemName: eraserEnabled ? "eraser.fill" : "eraser")
                                .font(.title)
                                .foregroundColor(Color("primaryPurple"))
                                .padding(10)
                            
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
    var pastGuesses: some View {
        ScrollView {
            ForEach(matchManager.pastGuesses) { guess in
                HStack {
                    Text(guess.message)
                        .font(.title2)
                        .bold(guess.correct)
                    
                    if guess.correct {
                        Image(systemName: "hand.thuumbup.fill")
                            .foregroundColor(matchManager.currentlyDrawing ?
                                             Color(red: 0.808, green: 0.345, blue: 0.776) :
                                                Color(red: 0.243, green: 0.773, blue: 0.745)
                            )
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 1)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            (matchManager.currentlyDrawing ?
             Color(red: 0.243, green: 0.773, blue: 0.745) :
                Color("primaryYellow")
            )
            .brightness(-0.2)
            .opacity(0.5)
        )
        .cornerRadius(20)
        .padding(.vertical)
        .padding(.bottom, 130 )
    }
    
    var promptGroup: some View {
        VStack {
            if matchManager.currentlyDrawing {
                Label("draw:".uppercased(), systemImage: "exclamationmark.bubble.fill")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Text(matchManager.drawPrompt.uppercased())
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundColor(Color("primaryYellow"))
                
            } else {
                HStack{
                    Label("Guess the drawing :".uppercased(), systemImage: "exclamationmark.bubble.fill")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color("primaryPurple"))
                    Spacer()
                }
                HStack {
                    TextField("Type your guess", text: $drawingGuess)
                        .padding()
                        .background(
                            Capsule(style: .circular)
                                .fill(.white)
                        )
                        .onSubmit(makeGuess)
                    
                    Button {
                        makeGuess()
                    } label: {
                        Image(systemName: "chevron.right.circle.fill")
                            .renderingMode(.original)
                            .foregroundColor(Color("primaryPurple"))
                            .font(.system(size: 50))
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding([.horizontal, .bottom ], 30)
        .padding(.vertical)
        .background(
            (matchManager.currentlyDrawing ?  Color(red: 0.243, green: 0.773, blue: 0.745) :
                Color("primaryYellow")
            )
            .opacity(0.5)
            .brightness(-0.2)
        )
    }
    
}

#Preview {
    GameView(matchManager: MatchManager())
}

