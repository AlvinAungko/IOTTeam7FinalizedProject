//
//  extension+NSObject.swift
//  FoodDetectApp
//
//  Created by Aung Ko Ko on 24/05/2023.
//

import Foundation

public extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
    
    func calculatePercentage(sensorValue: Int) -> Int {
        var percentage: Int = 0
        
        if sensorValue > 300 {
            // Calculate the percentage based on the value above 300
            let excess = sensorValue - 300
            let range = 700 // 1000 - 300 (maximum possible range)
            percentage = Int(Double(excess) / Double(range) * 30.0)
            percentage += 30 // Minimum value of 30%
        } else if sensorValue >= 200 && sensorValue <= 300 {
            // Calculate the percentage based on the value between 200 and 300
            let range = 100 // 300 - 200
            let withinRange = sensorValue - 200
            percentage = Int(Double(withinRange) / Double(range) * 20.0)
            percentage += 50 // Minimum value of 50%
        } else {
            // Calculate the percentage based on the value below 200
            let range = 200 // 200 - 0
            let belowRange = 200 - sensorValue
            percentage = Int(Double(belowRange) / Double(range) * 30.0)
            percentage += 80 // Minimum value of 80%
        }
        
        return percentage
    }
    
}
