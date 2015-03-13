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
    @IBOutlet weak var historyDisplay: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    var userTypedPoint: Bool = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            if digit == "." && !userTypedPoint {
                userTypedPoint = true
                display.text = display.text! + digit;
            }
            else if digit != "." {
                display.text = display.text! + digit;
            }
        }
        else {
            if digit == "." {
                userTypedPoint = true
                display.text = "0."
            }
            else {
                display.text = digit
            }
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    
    @IBAction func appendVariable(sender: UIButton) {
        let variable = sender.currentTitle!
        if let result = brain.pushOperand(variable) {
            displayValue = result
        } else {
            displayValue = nil
        }
        historyDisplay.text = "\(brain)"
    }
    
//    var operandStack = Array<Double>()
    var brain = CalculatorBrain()

    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        userTypedPoint = false
        
        if let operandValue = displayValue {
            if let result = brain.pushOperand(operandValue) {
                displayValue = result
            } else {
                displayValue = nil
            }
        }
        historyDisplay.text = "\(brain)"
    }
    
    var displayValue: Double? {
        get {
            return ((display.text) != nil) ? NSNumberFormatter().numberFromString(display.text!)!.doubleValue : nil
        }
        set {
            if newValue == nil {
                display.text = " "
            } else {
                display.text = "\(newValue!)"
            }
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        //let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = nil
            }
        }
        
        historyDisplay.text = "\(brain)"
    }
    
    @IBAction func addConstant(sender: UIButton) {
        var constant = "0"
        if let constantText = sender.currentTitle {
            switch constantText {
            case "π": constant = "\(M_PI)"
            default: break
            }
        }
        display.text = "\(constant)"
        enter()
    }
    
    @IBAction func clear() {
        historyDisplay.text = "";
        display.text = "0";
        userIsInTheMiddleOfTypingANumber = false;
        userTypedPoint = false;
        brain.clear()
    }
    
    @IBAction func setMemory(sender: UIButton) {
        brain.variableValues["M"] = displayValue
        userIsInTheMiddleOfTypingANumber = false;
        displayValue = brain.evaluate()
    }
    
}

