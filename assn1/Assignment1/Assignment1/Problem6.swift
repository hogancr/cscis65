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
        print("*Problem 6*")
        
        let testCase1 = ["Ham":345, "Cheese":115]
        
        // FIXME - don't understand the self check...leaving off ServiceLevel here gives me an error that Good is an unresolved identifier
        printBillForItems(testCase1, serviceLevel:RestaurantUtils.ServiceLevel.Good)
    }
    
    static func printBillForItems(items : [String:Int], serviceLevel : RestaurantUtils.ServiceLevel) {
        let bill = billForItems(items, serviceLevel: serviceLevel)
        print("Your bill summary: \(bill.description)")
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