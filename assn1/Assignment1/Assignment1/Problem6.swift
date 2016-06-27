//
//  Problem6.swift
//  Assignment1
//
//  Created by Christopher Hogan on 6/26/16.
//  Copyright © 2016 Christopher Hogan. All rights reserved.
//

import Foundation

struct Problem6 {
    
    static let taxRate = 0.07
    
    struct Bill {
        var baseCost : Int
        var tax : Int
        var tip : Int
        var total: Int {
            get {
                return baseCost + tax + tip
            }
        }
        var description: String {
            get {
                return "base: \(RestaurantUtils.formatCentsValueForScreen(baseCost)) tax: \(RestaurantUtils.formatCentsValueForScreen(tax)) tip: \(RestaurantUtils.formatCentsValueForScreen(tip)) total: \(RestaurantUtils.formatCentsValueForScreen(total))"
            }
        }

    }
    
    static func run() {
        print("\n*Problem 6*")
        
        let testCase1 = ["Ham":345, "Cheese":115]
        let testCase2 = [String:Int]()
        let testCase3 = ["Ham":420]
        let testCase4 = ["Water":0]
        let testCase5 = ["Shoelace":-15]
        
        printBillForItems(testCase1, serviceLevel:.Poor)
        printBillForItems(testCase1, serviceLevel:.Good)
        printBillForItems(testCase1, serviceLevel:.Excellent)
        printBillForItems(testCase2, serviceLevel:.Good)
        printBillForItems(testCase3, serviceLevel:.Fair)
        printBillForItems(testCase3, serviceLevel:.Great)
        printBillForItems(testCase4, serviceLevel:.Good)
        printBillForItems(testCase5, serviceLevel:.Good)

    }
    
    static func printBillForItems(items : [String:Int], serviceLevel : RestaurantUtils.ServiceLevel) {
        let bill = billForItems(items, serviceLevel: serviceLevel)
        if bill.total<0 {
            // Assumes that individual items can have negative prices as long as the bill itself doesn't turn negative. Behavior under negative values is not specified in the problem so this should do. Could also have it throw an exception in the calculate method.
            print("\nError, bill cannot be negative!")
        } else {
            print("\nYour bill summary: \(bill.description)")
        }
    }
    
    static func billForItems(items : [String:Int], serviceLevel : RestaurantUtils.ServiceLevel) -> Bill {
        // Assumes you should wait until the end to calculate tax so you only round once.
        // It's not expressly stated in the problem but tax is not applied on the tip amount.
        let total = items.reduce(0, combine : { $0 + $1.1})
        let tax =  Double(total) * taxRate
        let tip = Double(total) * serviceLevel.rawValue
        return Bill(baseCost:total, tax: Int(round(tax)), tip: Int(round(tip)))
    }
    
}