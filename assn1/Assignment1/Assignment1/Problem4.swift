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
            if self%i == 0 {
                return false
            }
        }
        return true
    }
}

struct Problem4 {
    
    static func run() {
        print ("\n*Problem 4*")
        
        let testCase1 = [3,29,3,7,2,7,83]
        let testCase2 = [Int]()
        let testCase3 = [1]
        let testCase4 = [-1,0,1]
        let testCase5 = [4,6,8,9,10]
        let testCase6 = [2,3,5,7,11]
        
        printPrimesOf(testCase1)
        printPrimesOf(testCase2)
        printPrimesOf(testCase3)
        printPrimesOf(testCase4)
        printPrimesOf(testCase5)
        printPrimesOf(testCase6)
    }
    
    static func printPrimesOf(items : [Int]) {
        print("\nRunning Problem4 with \(items)")
        let primes = primesOf(items)
        if primes.isEmpty {
            print("The input array contains no primes")
        } else {
            print("The following values are positive prime: \(primes)")
        }
    }
    
    static func primesOf(items : [Int]) -> [Int] {
        return items.filter({$0.isPrime()})
    }
}