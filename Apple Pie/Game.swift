//
//  Game.swift
//  Apple Pie
//
//  Created by Greg Smorag on 10/11/2017.
//  Copyright © 2017 Greg Smorag. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int8
    var guessedLetters: [Character]
    var formatterWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += String(letter)
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
}
