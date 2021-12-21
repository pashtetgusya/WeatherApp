//
//  UserAuth.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 30.11.2021.
//

import Foundation

// MARK: - UserAuth
struct UserAuth: Codable {
    let success: Bool?
    let data: AuthData?
    let error: AuthError?
}

// MARK: - AuthData
struct AuthData: Codable {
    let token: String?
}

// MARK: - AuthError
struct AuthError: Codable {
    let message: String?
}
