//
//  StatisticsViewController.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 19.12.2021.
//

import Foundation
import UIKit
import Charts

class StatisticViewController: UIViewController {
    
    @IBOutlet var averageStatisticDate: UILabel!
    @IBOutlet var averageTemperatureValue: UILabel!
    @IBOutlet var averageHumidityValue: UILabel!
    @IBOutlet var averagePressureValue: UILabel!
    
    @IBOutlet var switchWeatherPeriod: UISegmentedControl!
    @IBOutlet weak var tempreatureChart: LineChartView!
    @IBOutlet weak var humidityChart: LineChartView!
    @IBOutlet weak var pressureChart: LineChartView!

    @IBAction func showMainWindowViewController() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainWindowViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainWindow")
        mainWindowViewController.modalTransitionStyle = .coverVertical
        mainWindowViewController.modalPresentationStyle = .overFullScreen
        self.present(mainWindowViewController, animated: true, completion: nil)
    }

    @IBAction func changePeriod() {
        switch switchWeatherPeriod.selectedSegmentIndex
        {
        case 0:
            self.updateDayWeatherMetrics()
        case 1:
            self.updateWeekWeatherMetrics()
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateDayWeatherMetrics()
    }
    
    private func updateDayWeatherMetrics() {
        ApiManager.shared.getDayWeatherMetrics { currentDayWeatherMetrics in
            self.validateDayWeatherMetrics(currentWeekWeatherMetrics: currentDayWeatherMetrics)
        }
    }
    
    private func updateWeekWeatherMetrics() {
        ApiManager.shared.getWeekWeatherMetrics { currentWeekWeatherMetrics in
            print(currentWeekWeatherMetrics)
            self.validateWeekWeatherMetrics(currentWeekWeatherMetrics: currentWeekWeatherMetrics)
        }
    }
    
    private func validateDayWeatherMetrics(currentWeekWeatherMetrics: DayWeather) {
        var listTempreature: [String: Double] = [:]
        var listHumidity: [String: Double] = [:]
        var listPressure: [String: Double] = [:]
        
        currentWeekWeatherMetrics.data?.listMetric?.forEach { day in
            listTempreature[day.date!] = day.temperature
            listHumidity[day.date!] = day.humidity
            listPressure[day.date!] = day.pressure
        }
        
        DispatchQueue.main.async {
            self.averageStatisticDate.text = currentWeekWeatherMetrics.data?.lastDay?.date
            self.averageTemperatureValue.text = String((currentWeekWeatherMetrics.data?.lastDay?.temperature)!)
            self.averageHumidityValue.text = String((currentWeekWeatherMetrics.data?.lastDay?.humidity)!)
            self.averagePressureValue.text = String((currentWeekWeatherMetrics.data?.lastDay?.pressure)!)
        }
        
        self.drawChart(sender: self.tempreatureChart, weatherMetrics: listTempreature, type: "day")
        self.drawChart(sender: self.humidityChart, weatherMetrics: listHumidity, type: "day")
        self.drawChart(sender: self.pressureChart, weatherMetrics: listPressure, type: "day")
        
    }

    private func validateWeekWeatherMetrics(currentWeekWeatherMetrics: WeekWeather) {
        var listTempreature: [String: Double] = [:]
        var listHumidity: [String: Double] = [:]
        var listPressure: [String: Double] = [:]
        
        currentWeekWeatherMetrics.data?.listDays?.forEach { day in
            listTempreature[day.date!] = day.temperature
            listHumidity[day.date!] = day.humidity
            listPressure[day.date!] = day.pressure
        }

        DispatchQueue.main.async {
            self.averageStatisticDate.text = currentWeekWeatherMetrics.data?.lastWeek?.date
            self.averageTemperatureValue.text = String((currentWeekWeatherMetrics.data?.lastWeek?.temperature)!)
            self.averageHumidityValue.text = String((currentWeekWeatherMetrics.data?.lastWeek?.humidity)!)
            self.averagePressureValue.text = String((currentWeekWeatherMetrics.data?.lastWeek?.pressure)!)
        }
        
        self.drawChart(sender: self.tempreatureChart, weatherMetrics: listTempreature, type: "week")
        self.drawChart(sender: self.humidityChart, weatherMetrics: listHumidity, type: "week")
        self.drawChart(sender: self.pressureChart, weatherMetrics: listPressure, type: "week")
        
    }
    
    private func drawChart(sender: LineChartView, weatherMetrics: [String: Double], type: String) {
        
        var dataEntries: [ChartDataEntry] = []
        
        let sortedWeatherMetrics = weatherMetrics.sorted{ $0 < $1 }
        var times: [String] = []
        var metrics: [Double] = []
        
        sortedWeatherMetrics.forEach { metric in
            let dayDate = metric.key
            
            let dateFormatter = DateFormatter()
            if type == "day" {
                
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
                let dateObj = dateFormatter.date(from: dayDate)
                let dateString = dateFormatter.string(from: dateObj!)
                
                times.append(dateString[11...12])
                
            } else if type == "week" {
                
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateObj = dateFormatter.date(from: dayDate)
                let dateString = dateFormatter.string(from: dateObj!)
                
                times.append(dateString[5...9])
                                
            }
            
            metrics.append(metric.value)

        }

        for i in 0..<sortedWeatherMetrics.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: metrics[i])
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "")
        configLineChartDataSet(lineChartDataSet: lineChartDataSet)

        let lineChartData = LineChartData(dataSets: [lineChartDataSet])
        
        configLineChartView(sender: sender, countElements: times.count, axisLabelsElements: times)
        sender.data = lineChartData
    }
    
    
}
