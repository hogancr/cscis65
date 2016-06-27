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
        print("\n*Problem7*")
        
        let myBill = RestaurantBill()
        testAddingItemToBill(myBill,description:"Ham",quantity:1,priceEach:345,shouldFail:false)
        testAddingItemToBill(myBill,description:"Cheese",quantity:1,priceEach:115,shouldFail:false)
        // price already known, this time it's ignored
        testAddingItemToBill(myBill,description:"Ham",quantity:2,priceEach:0,shouldFail:false)
        
        // test different service levels
        testChangingServiceLevel(myBill, serviceLevel: .Poor)
        testChangingServiceLevel(myBill, serviceLevel: .Fair)
        testChangingServiceLevel(myBill, serviceLevel: .Good)
        testChangingServiceLevel(myBill, serviceLevel: .Great)
        testChangingServiceLevel(myBill, serviceLevel: .Excellent)
        
        // add one more time for good measure
        testAddingItemToBill(myBill,description:"Mustard",quantity:1,priceEach:65,shouldFail:false)
        
        // test errors
        testAddingItemToBill(myBill,description:"Gold",quantity:2,priceEach:120000,shouldFail:true)
        testAddingItemToBill(myBill,description:"Shoelace",quantity:2,priceEach:-15,shouldFail:true)
        testAddingItemToBill(myBill,description:"Gum",quantity:-1,priceEach:135,shouldFail:true)
        testAddingItemToBill(myBill,description:"Dollars",quantity:1000000,priceEach:1000000,shouldFail:true)
        testAddingItemToBill(myBill,description:"",quantity:1,priceEach:150,shouldFail:true)
    }
    
    static func testAddingItemToBill(bill: RestaurantBill, description: String, quantity: Int, priceEach: Int, shouldFail: Bool) {
        if shouldFail {
            print("\nThe following add should fail: \(description) (\(quantity)@\(RestaurantUtils.formatCentsValueForScreen(priceEach)))")
        } else {
            print("\nAdding to bill: \(description), (\(quantity)@\(RestaurantUtils.formatCentsValueForScreen(priceEach)))")
        }
        
        do {
            try bill.addItem(description, quantity: quantity, priceEach: priceEach)
            printBill(bill)
        } catch RestaurantBill.ItemEntryError.InvalidQuantity {
            print(RestaurantBill.ItemEntryError.InvalidQuantity.message)
        } catch RestaurantBill.ItemEntryError.HighQuantity {
            print(RestaurantBill.ItemEntryError.HighQuantity.message)
        } catch RestaurantBill.ItemEntryError.NegativePrice {
            print(RestaurantBill.ItemEntryError.NegativePrice.message)
        } catch RestaurantBill.ItemEntryError.HighPrice {
            print(RestaurantBill.ItemEntryError.HighPrice.message)
        } catch RestaurantBill.ItemEntryError.NoDescription {
            print(RestaurantBill.ItemEntryError.NoDescription.message)
        } catch {
            print("Unrecognized error entering item")
        }
    }
    
    static func testChangingServiceLevel(bill: RestaurantBill, serviceLevel: RestaurantUtils.ServiceLevel) {
        print("\nSetting service level to \(serviceLevel)=\(RestaurantUtils.formatPercentValueForScreen(serviceLevel.rawValue))")
        bill.serviceLevel = serviceLevel
        printBill(bill)
    }
    
    static func printBill(bill : RestaurantBill) {
        // FIXME - assume by "percent" the question means "of base bill?"
        print(bill.description)
        print("Tax \(RestaurantUtils.formatPercentValueForScreen(bill.taxRate)): \(RestaurantUtils.formatCentsValueForScreen(bill.tax))")
        print("Tip \(RestaurantUtils.formatPercentValueForScreen(bill.serviceLevel.rawValue)): \(RestaurantUtils.formatCentsValueForScreen(bill.tip))")
        print("Final Total: \(RestaurantUtils.formatCentsValueForScreen(bill.finalTotal))")
    }
}

class RestaurantBill {
    
    // It would be nice to use the bounds values below to construct these strings, but that doesn't appear to be possible... compiler demands a literal
    enum ItemEntryError: ErrorType {
        case InvalidQuantity
        case NegativePrice
        case HighQuantity
        case HighPrice
        case NoDescription
        
        var message : String {
            get {
                switch self {
                case ItemEntryError.InvalidQuantity :
                    return "Item entry error! Quantity must be at least \(ItemEntryErrorBounds.MinQuantity)"
                case ItemEntryError.HighQuantity :
                    return "Item entry error! Quantity must be at most \(ItemEntryErrorBounds.MaxQuantity)"
                case ItemEntryError.NegativePrice:
                    return "Item entry error! Price must be at least \(RestaurantUtils.formatCentsValueForScreen(ItemEntryErrorBounds.MinPrice))"
                case ItemEntryError.HighPrice:
                    return "Item entry error! Price must be at most \(RestaurantUtils.formatCentsValueForScreen(ItemEntryErrorBounds.MaxPrice))"
                case ItemEntryError.NoDescription:
                    return "Item entry error! The description cannot be empty."
                }
            }
        }
    }
    
    struct ItemEntryErrorBounds {
        static let MinPrice=0
        static let MinQuantity=1
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
    
    // FIXME - there doesn't appear to be a didset equivalent for Dictionaries, so we will instead do the finalTotal update in the addItem method. Is this the only way?
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
    
    // we should be using a private set on these, but this only hides it from use outside this file apparently, so
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
        if quantity<ItemEntryErrorBounds.MinQuantity {
            throw ItemEntryError.InvalidQuantity
        } else if priceEach<ItemEntryErrorBounds.MinPrice {
            throw ItemEntryError.NegativePrice
        } else if quantity > ItemEntryErrorBounds.MaxQuantity {
            throw ItemEntryError.HighQuantity
        } else if priceEach>ItemEntryErrorBounds.MaxPrice {
            throw ItemEntryError.HighPrice
        } else if description.isEmpty {
            throw ItemEntryError.NoDescription
        }
        
        
        if let itemEntry = itemizedBill[description] {
            // entry already exists, just increment quantity by the new amount
            itemizedBill[description] = ItemDetails(quantity: itemEntry.quantity + quantity, price: itemEntry.price)
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