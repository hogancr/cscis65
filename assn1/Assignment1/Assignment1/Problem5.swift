//
//  Problem5.swift
//  Assignment1
//
//  Created by Christopher Hogan on 6/26/16.
//  Copyright © 2016 Christopher Hogan. All rights reserved.
//

import Foundation

struct Problem5 {
    
    static let taxRate = 0.07
    
    static func run() {
        print("\n*Problem 5*")
        
        let testCase1 = ["Ham":345, "Cheese":115]
        let testCase2 = [String:Int]()
        let testCase3 = ["Ham":420]
        let testCase4 = ["Water":0]
        let testCase5 = ["Shoelace":-15]
        
        printTotalForItems(testCase1, serviceLevel:.Poor)
        printTotalForItems(testCase1, serviceLevel:.Good)
        printTotalForItems(testCase1, serviceLevel:.Excellent)
        printTotalForItems(testCase2, serviceLevel:.Good)
        printTotalForItems(testCase3, serviceLevel:.Fair)
        printTotalForItems(testCase3, serviceLevel:.Great)
        printTotalForItems(testCase4, serviceLevel:.Good)
        printTotalForItems(testCase5, serviceLevel:.Good)

        
    }
    
    static func printTotalForItems(items : [String:Int], serviceLevel : RestaurantUtils.ServiceLevel) {
        let totalBill = totalInclTipWithItems(items, serviceLevel: serviceLevel)
        if totalBill<0 {
            // Assumes that individual items can have negative prices as long as the bill itself doesn't turn negative. Behavior under negative values is not specified in the problem so this should do. Could also have it throw an exception in the calculate method.
            print("\nError, bill cannot be negative!")
        } else {
            print("\nYour bill including tax and tip comes to \(RestaurantUtils.formatCentsValueForScreen(totalBill))")            
        }
    }
    
    static func totalInclTipWithItems(items : [String:Int], serviceLevel : RestaurantUtils.ServiceLevel) -> Int {
        // Assumes you should calculate tax on the sum rather than summing item+tax so you only round once.
        // It's not expressly stated in the problem but tax is not applied on the tip amount.
        let total = items.reduce(0, combine : { $0 + $1.1})
        let tip = Double(total) * serviceLevel.rawValue
        let tax =  Double(total) * taxRate
        return total + Int(round(tip+tax))
    }
}