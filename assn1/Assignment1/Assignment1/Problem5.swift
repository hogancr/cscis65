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
        print("*Problem 5*")
        
        let testCase1 = ["Ham":345, "Cheese":115]
        
        // FIXME - don't understand the self check...leaving off ServiceLevel here gives me an error that Good is an unresolved identifier
        printTotalForItems(testCase1, serviceLevel:RestaurantUtils.ServiceLevel.Good)
    }
    
    static func printTotalForItems(items : [String:Int], serviceLevel : RestaurantUtils.ServiceLevel) {
        let totalBill = totalInclTipWithItems(items, serviceLevel: serviceLevel)
        print("Your bill including tax and tip comes to \(RestaurantUtils.formatCentsValueForScreen(totalBill))")
    }
    
    static func totalInclTipWithItems(items : [String:Int], serviceLevel : RestaurantUtils.ServiceLevel) -> Int {
        // Assumes you should wait until the end to calculate tax so you only round once.
        // It's not expressly stated in the problem but tax is not applied on the tip amount.
        let total = items.reduce(0, combine : { $0 + $1.1})
        let tip = Double(total) * serviceLevel.rawValue
        let tax =  Double(total) * taxRate
        return total + Int(round(tip+tax))
    }
}