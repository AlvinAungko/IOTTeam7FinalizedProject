//
//  FoodStatusCell.swift
//  FoodDetectApp
//
//  Created by Alvin  on 23/05/2023.
//

enum Foodstatus {
    case spoiled
    case normal
    case good
}

import UIKit
import Lottie

class FoodStatusCell: UITableViewCell {
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var goodStatusIcon: LottieAnimationView!
    @IBOutlet weak var badStatusIcon: LottieAnimationView!
    @IBOutlet weak var foodStatus: UILabel!
    @IBOutlet weak var foodPercentageLabel: UILabel!
    @IBOutlet weak var temperatureValueLabel: UILabel!
    @IBOutlet weak var humidityValueLabel: UILabel!
    
    
    var item: FoodStatusModel? {
        didSet {
            if let model = item {
                self.bindData(item: model)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.badStatusIcon.isHidden = true
        self.goodStatusIcon.isHidden = true
        self.createAnimationForGoodStatusIcon()
        self.createAnimationForBadStausIcon()
        self.selectionStyle = .none
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func bindData(item: FoodStatusModel) {
        switch item.foodStatus {
        case .spoiled:
            badStatusIcon.isHidden = false
            goodStatusIcon.isHidden = true
            foodStatus.text = item.eatableStatus ?? ""
            foodPercentageLabel.text = "Percentage = \(item.percentage ?? 0) %"
            temperatureValueLabel.text = "Temperature = \(item.temperatureValue ?? 0)"
            humidityValueLabel.text = "Humidity = \(item.humidityValue ?? 0)"
            mainTitle.text = "Spoiled Food Detection"
        case .good:
            badStatusIcon.isHidden = true
            goodStatusIcon.isHidden = false
            foodStatus.text = item.eatableStatus ?? ""
            foodPercentageLabel.text = "Percentage = \(item.percentage ?? 0) %"
            temperatureValueLabel.text = "Temperature = \(item.temperatureValue ?? 0)"
            humidityValueLabel.text = "Humidity = \(item.humidityValue ?? 0)"
            mainTitle.text = "Good Food Detection"
        case .normal:
            mainTitle.text = "Normal Food Detection"
            badStatusIcon.isHidden = true
            goodStatusIcon.isHidden = false
            foodStatus.text = item.eatableStatus ?? ""
            foodPercentageLabel.text = "Percentage = \(item.percentage ?? 0) %"
            temperatureValueLabel.text = "Temperature = \(item.temperatureValue ?? 0)"
            humidityValueLabel.text = "Humidity = \(item.humidityValue ?? 0)"
        default:
            break
        }
    }
    
    func createAnimationForGoodStatusIcon() {
        goodStatusIcon.contentMode = .scaleAspectFit
        goodStatusIcon.loopMode = .loop
        goodStatusIcon.animationSpeed = 0.5
        goodStatusIcon.play()
    }
    
    
    func createAnimationForBadStausIcon() {
        badStatusIcon.contentMode = .scaleAspectFit
        badStatusIcon.loopMode = .loop
        badStatusIcon.animationSpeed = 0.5
        badStatusIcon.play()
    }
    
}
