//
//  Problem4.swift
//  Assignment1
//
//  Created by Christopher Hogan on 6/26/16.
//  Copyright © 2016 Christopher Hogan. All rights reserved.
//

import Foundation

extension Int {
    public func isPrime () -> Bool {
        if self <= 1 {
            return false
        }
        
        let sqrtSelf = Int(sqrt(Double(self)))
        if sqrtSelf<2 {
            // this edge case would break the for loop below's range definition.
            // both two and three are prime
            return true
        }
        for i in 2...sqrtSelf {
            if (self%i == 0) {
                return false
            }
        }
        return true
    }
}

struct Problem4 {
    
    static func run() {
        print ("*Problem 4*")
        
        let testCase1 = [3,29,3,7,2,7,83]
        
        primesOf(testCase1)
        printPrimesOf(testCase1)
    }
    
    static func printPrimesOf(items : [Int]) {
        // FIXME - do we have to do anything special if there are no primes in the array?
        let primes = primesOf(items)
        print("The following values are positive prime: \(primes)")
    }
    
    static func primesOf(items : [Int]) -> [Int] {
        return items.filter({$0.isPrime()})
    }
}