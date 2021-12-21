//
//  UserInfo.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 19.12.2021.
//

import Foundation

struct UserProfileInfo: Codable {
    let success: Bool?
    let data: UserInfoData?
    let error: String?
}

// MARK: - UserInfoData
struct UserInfoData: Codable {
    let name, surname, patronymic: String?
}
