//
//  ViewController.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 16.11.2021.
//

import UIKit


class MainWindowViewController: UIViewController {

    @IBOutlet var currentDateLable: UILabel!
    @IBOutlet var currentTemperatureLabel: UILabel!
    @IBOutlet var currentHumidityLabel: UILabel!
    @IBOutlet var currentPressureLabel: UILabel!
    
    @IBAction func logOut() {
        userDefaults.removeObject(forKey: "Authorization")
        
        let authStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let authViewController = authStoryboard.instantiateViewController(withIdentifier: "AuthWindow")
        authViewController.modalTransitionStyle = .coverVertical
        authViewController.modalPresentationStyle = .overFullScreen
        self.present(authViewController, animated: true, completion: nil)
    }
    
    @IBAction func showUserInfoViewController() {
        let userInfoStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let userInfoViewController = userInfoStoryboard.instantiateViewController(withIdentifier: "UserInfoWindow")
        userInfoViewController.modalTransitionStyle = .coverVertical
        userInfoViewController.modalPresentationStyle = .overFullScreen
        self.present(userInfoViewController, animated: true, completion: nil)
    }
    
    @IBAction func showStatisticsViewController() {
        let statisticsStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let statisticViewController = statisticsStoryboard.instantiateViewController(withIdentifier: "StatisticsWindow")
        statisticViewController.modalTransitionStyle = .coverVertical
        statisticViewController.modalPresentationStyle = .overFullScreen
        self.present(statisticViewController, animated: true, completion: nil)
    }
    
    @IBAction func renewCurrentWeather() {
        self.updateCurrentWeather()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateCurrentWeather()
    }
    
    private func updateCurrentWeather() {
        
        ApiManager.shared.getCurrentWeather { currentWeather in
            let dateDayFormatter = DateFormatter()
            dateDayFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
            let date = dateDayFormatter.date(from: (currentWeather.data?.date)!)
            let newDate = DateFormatter.localizedString(from: date!, dateStyle: .full, timeStyle: .full)
            let newTemperature = String((currentWeather.data?.temperature)!)
            let newHumidity = String((currentWeather.data?.humidity)!)
            let newPressure = String((currentWeather.data?.pressure)!)
            
            DispatchQueue.main.async {
                self.currentDateLable.text = newDate
                self.currentTemperatureLabel.text = "Температура: \(newTemperature)"
                self.currentHumidityLabel.text = "Влажность: \(newHumidity)"
                self.currentPressureLabel.text = "Давление: \(newPressure)"
//                self.updateCurrentWeatherLabelText(sender: self.currentTemperatureLabel, newData: newTemperature)
//                self.updateCurrentWeatherLabelText(sender: self.currentHumidityLabel, newData: newHumidity)
//                self.updateCurrentWeatherLabelText(sender: self.currentPressureLabel, newData: newPressure)
            }
        }
    }
    
    private func updateCurrentWeatherLabelText(sender: UILabel, newData: String) {
        sender.text! = newData
    }

}
