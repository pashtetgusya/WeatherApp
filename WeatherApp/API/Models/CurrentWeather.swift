//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 16.11.2021.
//

import Foundation

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    let success: Bool?
    let data: MetricsData?
    let error: String?
}

// MARK: - MetricsData
struct MetricsData: Codable {
    let date: String?
    let temperature, pressure, humidity: Double?
}
