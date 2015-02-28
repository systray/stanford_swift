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
    
//    var operandStack = Array<Double>()
    var brain = CalculatorBrain()
    var inputHistoryStack = Array<String>()

    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        userTypedPoint = false
        historyDisplay.text = historyDisplay.text! + "\(displayValue)";
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            // TODO: displayValue an optional
            displayValue = nil
        }
    }
    
    var displayValue: Double? {
        get {
            return ((display.text) != nil) ? NSNumberFormatter().numberFromString(display.text!)!.doubleValue : nil
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        //let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            historyDisplay.text = historyDisplay.text! + operation;
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
//        switch operation {
//            case "×": perfomOperation {$0 * $1}
//            case "÷": perfomOperation {$1 / $0}
//            case "−": perfomOperation {$1 - $0}
//            case "+": perfomOperation {$0 + $1}
//            case "√": perfomOperation {sqrt($0)}
//            case "sin": perfomOperation {sin($0)}
//            case "cos": perfomOperation {cos($0)}
//            case "π": addConstant(M_PI)
//            default: break
//        }
    }
    
//    func perfomOperation(operation: (Double, Double) -> Double) {
//        if operandStack.count >= 2 {
//            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
//            enter()
//        }
//    }
//    
//    func perfomOperation(operation: Double -> Double) {
//        if operandStack.count >= 1 {
//            displayValue = operation(operandStack.removeLast())
//            enter()
//        }
//    }
//    
//    func addConstant(constant: Double) {
//        displayValue = constant
//        enter()
//    }
    
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
        //operandStack = []
        
    }
}

