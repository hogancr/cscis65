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
        print("*Problem 3*")
        
        let testCase1 = ["Ham":345, "Cheese":115]
        
        printTotalForItems(testCase1)
    }
    
    static func printTotalForItems(items : [String:Int]) {
        let totalBill = calculateTotalForItems(items)
        print("Your bill including tax comes to \(RestaurantUtils.formatCentsValueForScreen(totalBill)).")
    }
    
    static func calculateTotalForItems(items : [String:Int]) -> Int {
        // Assumes you should wait until the end to calculate tax so you only round once.
        let total = items.reduce(0, combine : { $0 + $1.1})
        let totalPlusTax =  Double(total) * (1+taxRate)
        return Int(round(totalPlusTax))
    }
}