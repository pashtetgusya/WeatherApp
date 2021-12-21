//
//  DeleteDevice.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 21.12.2021.
//

import Foundation

// MARK: - UserDeviceDelete
struct UserDeviceDelete: Codable {
    let success: Bool?
    let data: DeleteData?
    let error: DeleteErrorData?
}

// MARK: - DeleteData
struct DeleteData: Codable {
    let message: String?
}

// MARK: - DeleteErrorData
struct DeleteErrorData: Codable {
    let message: String?
}
