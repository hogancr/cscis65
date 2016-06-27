//
//  Problem7.swift
//  Assignment1
//
//  Created by Christopher Hogan on 6/26/16.
//  Copyright © 2016 Christopher Hogan. All rights reserved.
//

import Foundation

struct Problem7 {
    // FIXME - supposed to do six test cases with incremental changes between them, and throw some errors.
    
    static func run() {
        print("*Problem7*")
        
        // FIXME - is there really no way to have a single catch clause for all the items in RestaurantBill.ItemEntryError???
        do {
            let myBill = RestaurantBill()
            try myBill.addItem("Ham",quantity:1,priceEach:345)
            try myBill.addItem("Cheese",quantity:1,priceEach:115)
            // price already known, this time it's ignored
            try myBill.addItem("Ham",quantity:2,priceEach:0)
            printBill(myBill)
        } catch(RestaurantBill.ItemEntryError.HighPrice) {
            print("Item entry error! Price must be less than $20")
        } catch(RestaurantBill.ItemEntryError.NegativePrice) {
            print("Item entry error! Price must be greater than or equal to $20")
        } catch RestaurantBill.ItemEntryError.InvalidQuantity(let minQuantity) {
            print("Item entry error! Quantity must be greater than \(minQuantity)")
        } catch RestaurantBill.ItemEntryError.InvalidQuantity(let maxQuantity) {
            print("Item entry error! Quantity must be greater than \(maxQuantity)")
        } catch(RestaurantBill.ItemEntryError.HighPrice) {
            print("Item entry error! Price must be less than $20")
        } catch {
            print("Unrecognized error entering item")
        }
    }
    
    static func printBill(bill : RestaurantBill) {
        // FIXME - assume by "percent" the question means "of base bill?"
        print(bill.description)
        print("Tax \(Int(bill.taxRate*100))%: \(RestaurantUtils.formatCentsValueForScreen(bill.tax))")
        print("Tip \(Int(bill.serviceLevel.rawValue*100))%: \(RestaurantUtils.formatCentsValueForScreen(bill.tip))")
        print("Final Total: \(RestaurantUtils.formatCentsValueForScreen(bill.finalTotal))")
    }
}

class RestaurantBill {
    
    // It would be nice to use the bounds values below to construct these strings, but that doesn't appear to be possible... compiler demands a literal
    enum ItemEntryError: ErrorType {
        case InvalidQuantity (minQuantity: Int?, maxQuantity:Int?)
        case NegativePrice
        case HighQuantity
        case HighPrice
        case NoDescription
    }
    
    struct ItemEntryErrorBounds {
        static let MaxPrice=2000
        static let MaxQuantity=10
    }
    
    
    
    struct ItemDetails {
        var quantity: Int
        let price: Int
        
        func produceLineItemSummaryWithDescription(description : String) -> String {
            return "\(description) (\(quantity) @\(RestaurantUtils.formatCentsValueForScreen(price))) "
        }
    }
    
    init() {
        tax = 0
        tip = 0
        finalTotal = 0
        serviceLevel = RestaurantUtils.ServiceLevel.Good
    }
    
    // FIXME - there doesn't appear to be a didset equivalent for Dictionaries, so we will instead do the finalTotal update in the addItem method
    var itemizedBill = [String:ItemDetails]()
    
    var serviceLevel : RestaurantUtils.ServiceLevel {
        didSet {
            recomputeFinalTotal()
        }
    }
    let taxRate = 0.07 // this could also be defined as a stored property to support markets with other tax rates. If it could be set this would be another place to recomputeFinalTotal()

    var baseTotal : Int {
        get {
            return itemizedBill.reduce(0, combine: {(lhs: Int, rhs: (String,ItemDetails)) -> Int in return lhs + rhs.1.price*rhs.1.quantity})
        }
    }
    
    var tax : Int
    var tip : Int
    var finalTotal : Int
    
    var description : String {
        get {
            let summary = itemizedBill.reduce("", combine:{(lhs:String,rhs:(String,ItemDetails)) -> String in return lhs+rhs.1.produceLineItemSummaryWithDescription(rhs.0) })
            return "\(summary) Base Total: \(RestaurantUtils.formatCentsValueForScreen(baseTotal))"
        }
    }
    
    func addItem(description: String, quantity: Int, priceEach: Int) throws {
        // FIXME - check for bad data, e.g. price or quantity out of line, price of item changed, etc
        if (quantity<=0) {
            throw ItemEntryError.InvalidQuantity(minQuantity:0, maxQuantity:nil)
        } else if (priceEach<0) {
            throw ItemEntryError.NegativePrice
        } else if (quantity > ItemEntryErrorBounds.MaxQuantity) {
            throw ItemEntryError.InvalidQuantity(minQuantity:nil, maxQuantity:ItemEntryErrorBounds.MaxQuantity)

        } else if (priceEach>ItemEntryErrorBounds.MaxPrice) {
            throw ItemEntryError.HighPrice
        } else if (description.isEmpty) {
            throw ItemEntryError.NoDescription
        }
        
        
        if let itemEntry = itemizedBill[description] {
            // entry already exists, just increment quantity by the new amount
            //print("addItem \(quantity) of \(description), already has \(itemEntry.quantity)")
            itemizedBill[description] = ItemDetails(quantity: itemEntry.quantity + quantity, price: itemEntry.price)
            //print("addedItem \(itemEntry.quantity)")
        } else {
            // no entry exists, add a new one
            itemizedBill[description] = ItemDetails(quantity:quantity, price:priceEach)
        }
        
        recomputeFinalTotal()
    }
    
    func recomputeFinalTotal () {
        let itemTotal = baseTotal
        tax = Int(round(Double(baseTotal) * taxRate))
        tip = Int(round(Double(baseTotal) * serviceLevel.rawValue))
        finalTotal = itemTotal + tax + tip
    }
    
        
}