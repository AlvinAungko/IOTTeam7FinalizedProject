//
//  FoodStatusModel.swift
//  FoodDetectApp
//
//  Created by Aung Ko Ko on 24/05/2023.
//

import Foundation

enum FoodListIndex: Int {
    case good = 0
    case normal = 1
    case bad = 2
}

class FoodStatusModel {
    var percentage: Int?
    var foodStatus: Foodstatus?
    var eatableStatus: String?
    var ediatbleStatus: CellEditable?
    var temperatureValue: Int?
    var humidityValue: Int?
    
    init(percentage: Int? = nil, foodStatus: Foodstatus? = nil, eatableStatus: String? = nil, ediatbleStatus: CellEditable? = nil, temperatureValue: Int? =  nil, humidityValue: Int? = nil) {
        self.percentage = percentage
        self.foodStatus = foodStatus
        self.eatableStatus = eatableStatus
        self.ediatbleStatus = ediatbleStatus
        self.temperatureValue = temperatureValue
        self.humidityValue = humidityValue
    }
}
