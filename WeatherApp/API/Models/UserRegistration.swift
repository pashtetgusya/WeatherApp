//
//  UserRegistration.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 14.12.2021.
//

import Foundation

// MARK: - UserRegistration
struct UserRegistration: Codable {
    let success: Bool?
    let data: RegistrationMessage?
    let error: RegistrationError?
}

// MARK: - RegistrationMessage
struct RegistrationMessage: Codable {
    let message: String?
}

// MARK: - RegistrationError
struct RegistrationError: Codable {
    let message: String?
}
