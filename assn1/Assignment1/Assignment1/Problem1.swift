//
//  Problem1.swift
//  Assignment1
//
//  Created by Christopher Hogan on 6/22/16.
//  Copyright © 2016 Christopher Hogan. All rights reserved.
//

import Foundation


struct Problem1 {
    enum RangeError: ErrorType {
        case Over99
        case NegativeValue
    }
    
    static func run() {
        print("\n*Problem 1*")
        
        let testCase1 = [0,5,90,9,15,28,99,37,49,91]
        let testCase2 = [Int]()
        let testCase3 = [1]
        let testCase4 = [2, 90]
        let testCase5 = [0,5,90,9,15,28,99,37,49,91,99]
        
        runTestCase(testCase1)
        runTestCase(testCase2)
        runTestCase(testCase3)
        runTestCase(testCase4)
        runTestCase(testCase5)
    }
    
    static func runTestCase(testCase : [Int]) {
        do {
            print("\nRunning Problem1 with array \(testCase)")
            try printElementsOverFiftyCStyle(testCase)
            try printElementsOverFiftyRangeStyle(testCase)
        } catch RangeError.Over99 {
            print("Error: The input sequence includes a number greater than 99")
        } catch RangeError.NegativeValue {
            print("Error: The input sequence includes a negative number")
        } catch {
            // compiler seems to demand this.
            print("Error: unknown error occured.")
        }
    }
    
    static func printElementsOverFiftyCStyle(input : [Int])  throws {
        var overFifty = [Int]()
        
        for var i: Int = 0; i<input.count; i=i+1 {
            // This isn't explicitly called for but the question does say between 0 and 99, so let's play with exceptions
            if input[i]<0 {
                throw RangeError.NegativeValue
            }
            if input[i]>99 {
                throw RangeError.Over99
            }
            if input[i] > 50 {
                overFifty.append(input[i])
            }
        }
        print("With C-Style loop: \(overFifty)")
    }

    static func printElementsOverFiftyRangeStyle(input : [Int])  throws {
        var overFifty = [Int]()
        
        for i in 0..<input.count {
            // This isn't explicitly called for but the question does say between 0 and 99, so let's play with exceptions
            if input[i]<0 {
                throw RangeError.NegativeValue
            }
            if input[i]>99 {
                throw RangeError.Over99
            }
            if input[i] > 50 {
                overFifty.append(input[i])
            }
        }
        print("With for-in-Style loop: \(overFifty)")    }

}


