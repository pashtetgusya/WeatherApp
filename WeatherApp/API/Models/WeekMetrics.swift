//
//  WeekWeather.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 19.12.2021.
//

import Foundation

// MARK: - WeekWeather
struct WeekWeather: Codable {
    let success: Bool?
    let data: ListWeekMetricsData?
    let error: String?
}

// MARK: - ListWeekMetricsData
struct ListWeekMetricsData: Codable {
    let lastWeek: LastWeek?
    let listDays: [LastWeek]?

    enum CodingKeys: String, CodingKey {
        case lastWeek = "last_week"
        case listDays = "list_metric"
    }
}

// MARK: - LastWeek
struct LastWeek: Codable {
    let date: String?
    let temperature, pressure, humidity: Double?
}
