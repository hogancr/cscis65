//
//  Util.swift
//  Assignment1
//
//  Created by Christopher Hogan on 6/26/16.
//  Copyright © 2016 Christopher Hogan. All rights reserved.
//

import Foundation

struct RestaurantUtils {
    
    enum ServiceLevel:Double {
        case Poor = 0.1
        case Fair = 0.15
        case Good = 0.18
        case Great = 0.2
        case Excellent = 0.25
    }
    
    
    
    static func formatCentsValueForScreen(cents : Int) -> String {
        // FIXME - do we have to worry about commas in dollar amounts?
        // FIXME - do we have to do anything weird for small sums, like use the cent symbol rather than $0.XX?
        let dollars = Double(cents)/100.0
        return String(format: "$%.2f", dollars)
    }
    
    static func formatPercentValueForScreen(zeroToOne : Double) -> String {
        let percent = zeroToOne*100.0
        return String(format: "%.0f%%", percent)
    }

    
}