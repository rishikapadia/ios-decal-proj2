//
//  Hangman.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import Foundation

class Hangman {
    var words: HangmanWords!
    var answer: String?
    var knownString: String?
    var guessedLetters: NSMutableArray?
    var images: [String]
    
    init() {
        words = HangmanWords()
        images = [String]()
        for index in 1...7 {
            images.append("hangman\(index)")
        }
    }
    
    func start() {
        let word = words.getRandomWord()
        answer = word
        knownString = ""
        for (var i = 0; i < answer!.characters.count; i += 1) {
            //if (word as NSString).substringWithRange(NSMakeRange(i, 1)) == " " {
            if (word[word.startIndex.advancedBy(i)] == " ") {
                knownString = knownString! + " "
            } else {
                knownString = knownString! + "_"
            }
        }
        guessedLetters = NSMutableArray()
    }
    
    func guessLetter(letter: String) -> Bool {
        var result = false
        if guessedLetters!.containsObject(letter) {
            return true
        }
        guessedLetters!.addObject(letter)
        var chars = Array(answer!.characters)
        
        for (var i = 0; i < answer!.characters.count; i += 1) {
            if String(chars[i]) == letter {
                result = true
                knownString = "\((knownString! as NSString).substringToIndex(i))" + "\(letter)"
                            + "\((knownString! as NSString).substringFromIndex(i+1))"
            }
            
        }
        return result
    }
    
    func guesses() -> String {
        if guessedLetters!.count == 0 {
            return ""
        }
        var result: String = guessedLetters!.objectAtIndex(0) as! String
        for (var i = 1; i < guessedLetters!.count; i += 1) {
            result = result + ", \(guessedLetters!.objectAtIndex(i))"
        }
        return result
    }
    
    func isSolved() -> Bool {
        var result = true
        for (var i = 0; i < knownString!.characters.count; i += 1) {
            if knownString![knownString!.startIndex.advancedBy(i)] == "_" {
                result = false
            }
        }
        return result
    }

}