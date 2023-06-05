//
//  extension+UIView.swift
//  FoodDetectApp
//
//  Created by Aung Ko Ko on 24/05/2023.
//

import Foundation
import UIKit

public extension UIView {
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.className, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}
