//
//  DayWeather.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 19.12.2021.
//

import Foundation

// MARK: - DayWeather
struct DayWeather: Codable {
    let success: Bool?
    let data: ListDayMetricsData?
    let error: String?
}

// MARK: - ListDayMetricsData
struct ListDayMetricsData: Codable {
    let lastDay: LastDay?
    let listMetric: [LastDay]?

    enum CodingKeys: String, CodingKey {
        case lastDay = "last_day"
        case listMetric = "list_metric"
    }
}

// MARK: - LastDay
struct LastDay: Codable {
    let date: String?
    let temperature, pressure, humidity: Double?
}
