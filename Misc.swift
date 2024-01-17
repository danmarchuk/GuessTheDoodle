//
//  Misc.swift
//  GuessTheDoodle
//
//  Created by Данік on 16/01/2024.
//

import Foundation

let everydayObjects = [
    "Coffee mug", "Mobile phone", "Wallet", "Sunglasses", "Keychain", "Backpack", "Headphones", "Water bottle",
    "Umbrella", "Watch", "Laptop", "Notebook", "Pen", "Tissue box", "Hand sanitizer", "Charger", "Remote control",
    "Scissors", "Screwdriver", "Plants", "Mirror", "Toothbrush", "Toothpaste", "Hairbrush", "Fork", "Knife", "Spoon",
    "Plate", "Glass", "Television", "Couch", "Lightbulb", "Trash can", "Alarm clock", "Hangers", "Shoes", "Comb",
    "Sunscreen", "Basketball", "Ruler"
]

enum PlayerAuthState: String {
    case authenticating = "Logging in to Game Center..."
    case unauthenticating = "Please sing in to the Game center to play."
    case authenticated =  ""
    
    case error = "There was an error logging into Game Center."
    case restricted = "You are no t allowed to play multiplater games!"
}

struct PastGuess: Identifiable {
    let id = UUID()
    var message: String
    var correct: Bool
}

let maxTimeRemaining = 100
