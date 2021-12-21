//
//  CreateDevice.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 21.12.2021.
//

import Foundation

// MARK: - CreatedDevice
struct CreatedDevice: Codable {
    let success: Bool?
    let data: DeviceData?
    let error: CreateErrorData?
}

// MARK: - DeviceData
struct DeviceData: Codable {
    let name, tokenDevice: String?

    enum CodingKeys: String, CodingKey {
        case name
        case tokenDevice = "token_device"
    }
}

// MARK: - CreateErrorData
struct CreateErrorData: Codable {
    let message: String?
}
