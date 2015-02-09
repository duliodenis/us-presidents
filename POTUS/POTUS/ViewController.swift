//
//  ViewController.swift
//  POTUS
//
//  Created by Dulio Denis on 1/20/15.
//  Copyright (c) 2015 ddApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var potus1: UIButton!
    @IBOutlet weak var potus2: UIButton!
    @IBOutlet weak var potus3: UIButton!
    @IBOutlet weak var potus4: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // Array of Presidents File Names & Display Names
    var presidents = [String]()
    var presidentFormalName = [String]()
    
    // user's score
    var score = 0
    // the correct answer
    var correctAnswer = 0
    // the number of questions in the round
    var currentQuestion = 0
    var roundQuestions = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a border to the flags for flags with White
        potus1.layer.borderWidth = 1
        potus2.layer.borderWidth = 1
        potus3.layer.borderWidth = 1
        potus4.layer.borderWidth = 1
        
        presidents += ["01_george_washington", "02_john_adams", "03_thomas_jefferson", "04_james_madison", "05_james_monroe", "06_john_quincy_adams", "07_andrew_jackson", "08_martin_van_buren", "09_william_henry_harrison", "10_john_tyler"]
        presidentFormalName += ["George Washington", "John Adams", "Thomas Jefferson", "James Madison", "James Monroe", "John Quincy Adams", "Andrew Jackson", "Martin Van Buren", "William Henry Harrison", "John Tyler"]
        
        scoreLabel.text = ""
        askQuestion()
    }
    
    func askQuestion(action:UIAlertAction! = nil) {
        presidents.shuffle()
        potus1.setImage(UIImage(named: presidents[0]), forState: .Normal)
        potus2.setImage(UIImage(named: presidents[1]), forState: .Normal)
        potus3.setImage(UIImage(named: presidents[2]), forState: .Normal)
        potus4.setImage(UIImage(named: presidents[3]), forState: .Normal)
        
        correctAnswer = Int(arc4random_uniform(3))
        
        let name = presidents[correctAnswer]
        let index = name.substringWithRange(Range<String.Index>(start: name.startIndex, end: advance(name.startIndex, 2))).toInt()
        title = presidentFormalName[index!-1].uppercaseString
    }

    @IBAction func presidentTapped(sender: AnyObject) {
        var messageTitle: String
        if sender.tag == correctAnswer {
            messageTitle = "Correct"
            ++score
        } else {
            messageTitle = "Wrong"
            --score
        }
        
        ++currentQuestion
        let messageText = "Q\(currentQuestion): Your score is \(score)"
        scoreLabel.text = messageText
        
        if currentQuestion < roundQuestions {
            let alertController = UIAlertController(title: messageTitle, message: messageText, preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Continue", style: .Default, handler: askQuestion))
            presentViewController(alertController, animated: true, completion: nil)
        } else { // Round is Over
            let alertController = UIAlertController(title: "Game Over", message: messageText, preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Game Over", style: .Default, handler: roundComplete))
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func roundComplete(action:UIAlertAction! = nil) {
        navigationController?.popViewControllerAnimated(true)
    }
}

