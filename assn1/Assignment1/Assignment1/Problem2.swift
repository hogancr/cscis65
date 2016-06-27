//
//  Problem2.swift
//  Assignment1
//
//  Created by Christopher Hogan on 6/26/16.
//  Copyright © 2016 Christopher Hogan. All rights reserved.
//

import Foundation

struct Problem2 {

    static let englishNamesOfNumbersUnderTwenty = [0:"zero", 1:"one",2:"two",3:"three",4:"four",5:"five",6:"six",7:"seven",8:"eight",9:"nine",10:"ten",11:"eleven",12:"twelve",13:"thirteen",14:"fourteen",15:"fifteen",16:"sixteen",17:"seventeen",18:"eighteen",19:"nineteen"]
    static let englishNamesOfTensPlaces = [2:"twenty",3:"thirty",4:"fourty",5:"fifty",6:"sixty",7:"seventy",8:"eighty",9:"ninety"]
    
    
    static func run() {
        print("\n*Problem 2*")
        let testCase1 = [7,2,-13,300,6,26]
        let testCase2 = [Int]()
        let testCase3 = [7]
        let testCase4 = [-13]
        let testCase5 = [-13,300]
        
        printResultsOfIntegerTranslationToEnglishNames(testCase1)
        printResultsOfIntegerTranslationToEnglishNames(testCase2)
        printResultsOfIntegerTranslationToEnglishNames(testCase3)
        printResultsOfIntegerTranslationToEnglishNames(testCase4)
        printResultsOfIntegerTranslationToEnglishNames(testCase5)
        
    }

    static func printResultsOfIntegerTranslationToEnglishNames(values : [Int]) {
        var results = values.map(englishNameOfIntegerUnder100).map(describeResults)
        var output = String()
        for i in 0..<values.count {
            output = output + "\n\(values[i]): \(results[i]) "
        }
        print(output)
    }
    
    static func describeResults (result : String?) -> String {
        if let name = result {
            return name
        } else {
            return "no answer"
        }
    }
    
    static func englishNameOfIntegerUnder100(integerValue : Int) -> String? {
        if integerValue<0 || integerValue>99 {
            return nil
        } else if integerValue<20 {
            return englishNamesOfNumbersUnderTwenty[integerValue]
        } else {
            let tensPlace = integerValue/10
            let onesPlace = integerValue%10
            if onesPlace == 0 {
                return englishNamesOfTensPlaces[onesPlace]
            } else {
                if let tensPlaceName = englishNamesOfTensPlaces[tensPlace], onesPlaceName = englishNamesOfNumbersUnderTwenty[onesPlace] {
                    return "\(tensPlaceName)-\(onesPlaceName)"
                }
                else {
                    return nil
                }
            }
            
        }
        
    }
    
}