//
//  MatchManager.swift
//  GuessTheDoodle
//
//  Created by Данік on 16/01/2024.
//

// https://www.youtube.com/watch?v=X5E5oKdmJA0&ab_channel=DaveJacobsen
// https://youtu.be/HmlW18K_q_c?t=1140

import Foundation
import GameKit
import PencilKit

class MatchManager: NSObject, ObservableObject {
    @Published var inGame = false
    @Published var isGameOver = false
    @Published var authenticationState = PlayerAuthState.authenticating
    
    @Published var currentlyDrawing = true
    @Published var drawPrompt = "Dishwashed"
    @Published var pastGuesses = [PastGuess]()
    
    @Published var score = 0
    @Published var remainingTime = maxTimeRemaining
    @Published var lastReceivedDrawing = PKDrawing()
    @Published var isTimeKeeper = false
    
    var match: GKMatch?
    var otherPlayer: GKPlayer?
    var localPlayer = GKLocalPlayer.local
    
    var playerUIIDKey = UUID().uuidString
    
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = {[weak self] vc, e in
            guard let self = self else { return }
            
            if let viewController = vc {
                self.rootViewController?.present(viewController, animated: true)
                return
            }
            
            if let error = e {
                authenticationState = .error
                print(error.localizedDescription)
                
                return
            }
            
            if self.localPlayer.isAuthenticated {
                // if there is a parental control or any other restrictions
                if self.localPlayer.isMultiplayerGamingRestricted {
                    self.authenticationState = .restricted
                } else {
                    self.authenticationState = .authenticated
                }
            } else {
                self.authenticationState = .unauthenticating
            }
        }
    }
    
    func startMatchMaking() {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        
        guard let matchmakingVC = GKMatchmakerViewController(matchRequest: request) else {return}
        matchmakingVC.matchmakerDelegate = self
        
        rootViewController?.present(matchmakingVC, animated: true)
    }
    
    func startGame(newMatch: GKMatch) {
        match = newMatch
        match?.delegate = self
        
        otherPlayer = match?.players.first
        drawPrompt = everydayObjects.randomElement() ?? "Error Occured"
        
        sendString("began: \(playerUIIDKey)")
    }
    
    func receivedString(_ message: String) {
        let messageSplit = message.split(separator: ":")
        guard let messagePrefix = messageSplit.first else {return}
        
        let parameter = String(messageSplit.last ?? "")
        
        switch messagePrefix {
        case "began":
            if playerUIIDKey == parameter {
                playerUIIDKey = UUID().uuidString
                sendString("began:\(playerUIIDKey)")
                break
            }
            
            currentlyDrawing = playerUIIDKey < parameter
            inGame = true
            isTimeKeeper = true
            
            if isTimeKeeper {
                countdownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            }
            
        default:
            break
        }
    }
    
}
