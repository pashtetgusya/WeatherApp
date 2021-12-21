//
//  ChangeDevice.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 21.12.2021.
//

import Foundation

// MARK: - ChangeDevice
struct ChangeDevice: Codable {
    let success: Bool?
    let data: ChangedData?
    let error: ChangeErrorData?
}

// MARK: - ChangedDeviceData
struct ChangedData: Codable {
    let name, tokenDevice: String?

    enum CodingKeys: String, CodingKey {
        case name
        case tokenDevice = "token_device"
    }
}

// MARK: - ChangeErrorData
struct ChangeErrorData: Codable {
    let message: String?
}
