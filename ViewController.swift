//
//  ViewController.swift
//  FoodDetectApp
//
//  Created by Alvin  on 23/05/2023.
//

import UIKit
import NotificationBannerSwift
import NVActivityIndicatorView
import Lottie

enum CellEditable {
    case editable
    case notEditable
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inProgressView: LottieAnimationView!
    @IBOutlet weak var inProgressLabel: UILabel!
    
    let activityIndicatorView = NVActivityIndicatorView(
        frame: CGRect(x: 0, y: 0, width: 30, height: 30),
        type: .lineSpinFadeLoader,
        color: UIColor.blue
    )
    
    var foodStatus: Foodstatus?
    var foodList: [FoodStatusModel] = []
    var timer: Timer?
    var refresh = UIRefreshControl()
    var isDataLoading: Bool = true
    
    var methaneValue: Int?
    var temperatureValue: Int?
    var humidityValue: Int?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpTableView()
        createAnimationForInProgressIcon()
        
        self.inProgressView.isHidden = false
        self.inProgressLabel.numberOfLines = 2
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.title = "Food Spoilate Detect Dashboard"
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)])
        
        self.showLoading()
        self.showRefresh(refresh, selector: #selector(self.refresh(_:)))
        
        FirebaseDataManager.shared.getFirebaseValue(
            pathName: Constants.methaneValue) { [weak self] sensorValue in
                self?.methaneValue = sensorValue
                let banner = StatusBarNotificationBanner(title: "Sensors are Still Detecting", style: .info, colors: nil)
                banner.show()
                self?.foodList = self?.mockFoodStatusData(
                    sensorValue: self?.methaneValue ?? 0,
                    temperatureValue: self?.temperatureValue ?? 0,
                    humidityValue: self?.humidityValue ?? 0
                ) ?? []
                self?.tableView.reloadData()
            }
        
        FirebaseDataManager.shared.getFirebaseValue(
            pathName: Constants.temperatureValue) { [weak self] sensorValue in
                self?.temperatureValue = sensorValue
                self?.foodList = self?.mockFoodStatusData(
                    sensorValue: self?.methaneValue ?? 0,
                    temperatureValue: self?.temperatureValue ?? 0,
                    humidityValue: self?.humidityValue ?? 0
                ) ?? []
                self?.tableView.reloadData()
            }
        
        FirebaseDataManager.shared.getFirebaseValue(
            pathName: Constants.humidityValue) { [weak self] sensorValue in
                self?.humidityValue = sensorValue
                self?.foodList = self?.mockFoodStatusData(
                    sensorValue: self?.methaneValue ?? 0,
                    temperatureValue: self?.temperatureValue ?? 0,
                    humidityValue: self?.humidityValue ?? 0
                ) ?? []
                self?.tableView.reloadData()
            }
        
        
        self.hideLoading()
        
    }
    
    
    
    func setUpTableView() {
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInset = .zero
        tableView.separatorStyle = .none
        tableView.register(
            UINib(nibName: String(describing: FoodStatusCell.self), bundle: nil),
            forCellReuseIdentifier: String(describing: FoodStatusCell.self)
        )
    }
    
    @objc func refresh(_ sender: Any) {
        foodList.removeAll()
        tableView.reloadData()
        
        FirebaseDataManager.shared.getFirebaseValue(
            pathName: Constants.methaneValue) { [weak self] sensorValue in
                self?.methaneValue = sensorValue
                let banner = StatusBarNotificationBanner(title: "Sensors are Still Detecting", style: .info, colors: nil)
                banner.show()
                self?.foodList = self?.mockFoodStatusData(
                    sensorValue: self?.methaneValue ?? 0,
                    temperatureValue: self?.temperatureValue ?? 0,
                    humidityValue: self?.humidityValue ?? 0
                ) ?? []
                self?.tableView.reloadData()
                self?.refresh.endRefreshing()
            }
        
        FirebaseDataManager.shared.getFirebaseValue(
            pathName: Constants.temperatureValue) { [weak self] sensorValue in
                self?.temperatureValue = sensorValue
                self?.foodList = self?.mockFoodStatusData(
                    sensorValue: self?.methaneValue ?? 0,
                    temperatureValue: self?.temperatureValue ?? 0,
                    humidityValue: self?.humidityValue ?? 0
                ) ?? []
                self?.tableView.reloadData()
                self?.refresh.endRefreshing()
            }
        
        FirebaseDataManager.shared.getFirebaseValue(
            pathName: Constants.humidityValue) { [weak self] sensorValue in
                self?.humidityValue = sensorValue
                self?.foodList = self?.mockFoodStatusData(
                    sensorValue: self?.methaneValue ?? 0,
                    temperatureValue: self?.temperatureValue ?? 0,
                    humidityValue: self?.humidityValue ?? 0
                ) ?? []
                self?.tableView.reloadData()
                self?.refresh.endRefreshing()
            }
    }
    
    func createAnimationForInProgressIcon() {
        inProgressView.contentMode = .scaleAspectFit
        inProgressView.loopMode = .loop
        inProgressView.animationSpeed = 0.5
        inProgressView.play()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.inProgressView.isHidden = self.foodList.isEmpty ? false : true
        self.inProgressLabel.isHidden = self.foodList.isEmpty ? false : true
        return self.foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FoodStatusCell.self), for: indexPath) as? FoodStatusCell else {
            return UITableViewCell()
        }
        switch self.foodList[indexPath.row].ediatbleStatus {
        case .editable:
            cell.contentView.alpha = 1
            cell.isUserInteractionEnabled = true
        case .notEditable:
            cell.contentView.alpha = 0.2
            cell.isUserInteractionEnabled = false
        default:
            break
        }
        cell.item = self.foodList[indexPath.row]
        return cell
    }
    
    func showRefresh(_ refresh: UIRefreshControl, selector: Selector) {
        refresh.addTarget(self, action: selector, for: .valueChanged)
        tableView.addSubview(refresh)
    }
    
    func createLoadingView(_ loadingView: UIView, indicator: UIActivityIndicatorView) {
        loadingView.layer.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        indicator.color = UIColor.lightGray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        loadingView.addSubview(indicator)
        centerIndicator(loadingView, indicator: indicator)
        tableView.tableFooterView = loadingView
    }
    
    func centerIndicator(_ loadingView: UIView, indicator: UIActivityIndicatorView) {
        let xCenterConstraint = NSLayoutConstraint(
            item: loadingView, attribute: .centerX, relatedBy: .equal,
            toItem: indicator, attribute: .centerX, multiplier: 1, constant: 0
        )
        
        loadingView.addConstraint(xCenterConstraint)
        let yCenterConstraint = NSLayoutConstraint(
            item: loadingView, attribute: .centerY, relatedBy: .equal,
            toItem: indicator, attribute: .centerY, multiplier: 1, constant: 0
        )
        
        loadingView.addConstraint(yCenterConstraint)
    }
    
}

extension ViewController {
    func showLoading(message: String = "") {
        activityIndicatorView.startAnimating()
    }
    
    func hideLoading() {
        activityIndicatorView.stopAnimating()
    }
}


