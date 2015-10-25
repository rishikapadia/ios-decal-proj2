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
    
    @IBAction func newGame(sender: AnyObject) {
        game.start()
        numWrong = 0
        updateViews()
    }
    
    @IBAction func guessPressed(sender: AnyObject) {
        if guess.text!.characters.count != 1 || numWrong >= 7 {
            return
        }
        if (game.guessLetter(guess.text!)) {
            //already guessed this letter, or not in answer
            numWrong!++
        }
        updateViews()
    }
    
    func updateViews() {
        //guesses.text = "Guesses: " + game.guesses()
        image.image = UIImage(named: game.images[numWrong])!
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

