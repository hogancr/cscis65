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
        print("*Problem 1*")
        
        let testCase1 = [0,5,90,9,15,28,99,37,49,91]
        do {
            try printElementsOverFiftyCStyle(testCase1)
            try printElementsOverFiftyRangeStyle(testCase1)
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
        print(overFifty);
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
        print(overFifty);
    }

}


