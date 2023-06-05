//
//  extension+UITableView.swift
//  FoodDetectApp
//
//  Created by Aung Ko Ko on 24/05/2023.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCells(str: [String]) {
        
        str.forEach {
            self.register(
                UINib(nibName: $0, bundle: nil),
                forCellReuseIdentifier: $0
            )
        }
    }
    
    static var tableViewCellIdentifier: String {
        return self.className
    }
}
