//
//  ViewController.swift
//  Calculator
//
//  Created by smart on 2/17/15.
//  Copyright (c) 2015 9bits. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit;
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
}

