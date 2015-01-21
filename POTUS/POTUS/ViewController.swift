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
    
    // Array of Presidents
    var presidents = [String]()
    // user's score
    var score = 0
    // the correct answer
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a border to the flags for flags with White
        potus1.layer.borderWidth = 1
        potus2.layer.borderWidth = 1
        potus3.layer.borderWidth = 1
        potus4.layer.borderWidth = 1
        
        presidents += ["01_george_washington", "02_john_adams", "03_thomas_jefferson", "04_james_madison", "05_james_monroe"]
        askQuestion()
    }

    func askQuestion(action:UIAlertAction! = nil) {
        presidents.shuffle()
        potus1.setImage(UIImage(named: presidents[0]), forState: .Normal)
        potus2.setImage(UIImage(named: presidents[1]), forState: .Normal)
        potus3.setImage(UIImage(named: presidents[2]), forState: .Normal)
        potus4.setImage(UIImage(named: presidents[3]), forState: .Normal)
        
        correctAnswer = Int(arc4random_uniform(3))
        title = presidents[correctAnswer].uppercaseString
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
        
        let messageText = "Your score is \(score)"
        
        let alertController = UIAlertController(title: messageTitle, message: messageText, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .Default, handler: askQuestion))
        presentViewController(alertController, animated: true, completion: nil)
    }
}

