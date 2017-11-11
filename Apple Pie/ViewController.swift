//
//  ViewController.swift
//  Apple Pie
//
//  Created by Greg Smorag on 09/11/2017.
//  Copyright © 2017 Greg Smorag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let incorrectMovedAllowed: Int8 = 7
    
    var totalWins: Int8 = 0 {
        didSet {
            startNewRound()
        }
    }
    
    var totalLoses: Int8 = 0 {
        didSet {
            startNewRound()
        }
    }
    
    var listOfWords = ["some", "smelly", "zombie", "there", "dawid", "ida", "aga", "greg", "day", "said", "dad", "pizza", "here", "words", "poop", "come"]
    
    var currentGame: Game!

    @IBOutlet weak var treeView: UIImageView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startNewRound()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLoses += 1
        } else if currentGame.word == currentGame.formatterWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startNewRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovedAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formatterWord {
            letters.append(String(letter))
        }
        correctWordLabel.text = letters.joined(separator: " ")
        scoreLabel.text = "Wins: \(totalWins), Loses: \(totalLoses)"
        treeView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }

}

