//
//  Problem3.swift
//  Assignment1
//
//  Created by Christopher Hogan on 6/26/16.
//  Copyright © 2016 Christopher Hogan. All rights reserved.
//

import Foundation

struct Problem3 {
    
    static let taxRate = 0.07
    
    static func run() {
        print("\n*Problem 3*")
        
        let testCase1 = ["Ham":345, "Cheese":115]
        let testCase2 = [String:Int]()
        let testCase3 = ["Ham":420]
        let testCase4 = ["Water":0]
        let testCase5 = ["Shoelace":-15]
        
        printTotalForItems(testCase1)
        printTotalForItems(testCase2)
        printTotalForItems(testCase3)
        printTotalForItems(testCase4)
        printTotalForItems(testCase5)
    }
    
    static func printTotalForItems(items : [String:Int]) {
        let totalBill = calculateTotalForItems(items)
        if totalBill<0 {
            // Assumes that individual items can have negative prices as long as the bill itself doesn't turn negative. Behavior under negative values is not specified in the problem so this should do. Could also have it throw an exception in the calculate method.
            print("\nError, bill cannot be negative!")
        } else {
            print("\nYour bill including tax comes to \(RestaurantUtils.formatCentsValueForScreen(totalBill)).")
        }
    }
    
    static func calculateTotalForItems(items : [String:Int]) -> Int {
        // Assumes you should calculate tax on the sum rather than summing item+tax so you only round once.
        let total = items.reduce(0, combine : { $0 + $1.1})
        let totalPlusTax =  Double(total) * (1+taxRate)
        return Int(round(totalPlusTax))
    }
}