//
//  extension+ViewController.swift
//  FoodDetectApp
//
//  Created by Aung Ko Ko on 28/05/2023.
//

import Foundation
import UIKit

extension ViewController {
    func mockFoodStatusData(sensorValue: Int, temperatureValue: Int, humidityValue: Int) -> [FoodStatusModel] {
        
        let fairlyEatableFoodRange = 295...320
        let goodEatbleFoodRange = 200...270
        
        
        if sensorValue > 390 {
            
            return [
                FoodStatusModel(
                    percentage: 0,
                    foodStatus: .good,
                    eatableStatus: "-",
                    ediatbleStatus: .notEditable
                ),
                
                FoodStatusModel(
                    percentage: 0,
                    foodStatus: .normal,
                    eatableStatus: "-",
                    ediatbleStatus: .notEditable
                ),
                
                FoodStatusModel(
                    percentage: self.calculatePercentage(sensorValue: sensorValue),
                    foodStatus: .spoiled,
                    eatableStatus: "This Food is Not Fresh to Eat",
                    ediatbleStatus: .editable,
                    temperatureValue: temperatureValue,
                    humidityValue: humidityValue
                )
            ]
        } else if fairlyEatableFoodRange.contains(sensorValue), temperatureValue < 32 && humidityValue < 80 {
            return [
                FoodStatusModel(
                    percentage: 0,
                    foodStatus: .good,
                    eatableStatus: "-",
                    ediatbleStatus: .notEditable
                ),
                
                FoodStatusModel(
                    percentage: self.calculatePercentage(sensorValue: sensorValue),
                    foodStatus: .normal,
                    eatableStatus: "This Food is Fairly Fresh.",
                    ediatbleStatus: .editable,
                    temperatureValue: temperatureValue,
                    humidityValue: humidityValue
                ),
                
                FoodStatusModel(
                    percentage: 0,
                    foodStatus: .spoiled,
                    eatableStatus: "-",
                    ediatbleStatus: .notEditable
                )
            ]
        } else if temperatureValue < 32 && humidityValue < 80  {
            return [
                FoodStatusModel(
                    percentage: self.calculatePercentage(sensorValue: sensorValue),
                    foodStatus: .good,
                    eatableStatus: "This Food is Fully Fresh",
                    ediatbleStatus: .editable,
                    temperatureValue: temperatureValue,
                    humidityValue: humidityValue
                ),
                
                FoodStatusModel(
                    percentage: 0,
                    foodStatus: .normal,
                    eatableStatus: "-",
                    ediatbleStatus: .notEditable
                ),
                
                FoodStatusModel(
                    percentage: 0,
                    foodStatus: .spoiled,
                    eatableStatus: "-",
                    ediatbleStatus: .notEditable
                )
            ]
        } else {
            return []
        }
        
    }
}
