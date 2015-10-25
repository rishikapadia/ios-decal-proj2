//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    var game:Hangman!
    var numWrong:Int!
    
    @IBOutlet weak var guess: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var guesses: UILabel!
    @IBOutlet weak var wordSoFar: UILabel!
    
    @IBAction func newGame(sender: AnyObject) {
        game.start()
        numWrong = 0
        updateViews()
    }
    
    @IBAction func guessPressed(sender: AnyObject) {
        if (guess.text!.characters.count != 1 || numWrong >= 6) {
            guess.text = ""
            return
        }
        if (!game.guessLetter(guess.text!.uppercaseString)) {
            //this letter is not in the answer
            numWrong!++
        }
        updateViews()
        
        if (game.isSolved() || numWrong >= 6) {
            endGameState()
        }
    }
    
    func updateViews() {
        guess.text = ""
        guesses.text = "Guesses: \(game.guesses())"
        wordSoFar.text = game.knownString
        image.image = UIImage(named: game.images[numWrong])!
    }
    
    func endGameState() {
        var title = ""
        var message = ""
        if game.isSolved() {
            title = "Congratulations!"
            message = "You solved the puzzle!"
        } else if (numWrong >= 6) {
            wordSoFar.text = game.answer
            title = "Sorry!"
            message = "You failed to solve the puzzle..."
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // ...
        }
        let OKAction = UIAlertAction(title: "New Game", style: .Default) { (action) in
            self.newGame(self)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        game = Hangman()
        game.start()
        numWrong = 0
        updateViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

