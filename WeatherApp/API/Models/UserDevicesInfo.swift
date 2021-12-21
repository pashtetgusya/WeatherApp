//
//  UserDevicesInfo.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 21.12.2021.
//

import Foundation

// MARK: - UserDevicesInfo
struct UserDevicesInfo: Codable {
    let success: Bool?
    let data: DevicesData?
    let error: String?
}

// MARK: - DataClass
struct DevicesData: Codable {
    let devices: [Device]?
}

// MARK: - Device
struct Device: Codable {
    let name, token: String?
}
