//
//  ApiManager.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 16.11.2021.
//

import Foundation

var userDefaults = UserDefaults.standard


enum ApiType {
    
    case authUser
    case registration
    case createNewDevice
    case changeUserDevice
    case deleteUserDevice
    case getUserProfileInfo
    case getUserDevicesInfo
    case getCurrentWeather
    case getDayWeatherMetrics
    case getWeekWeatherMetrics
    
    
    var baseURL: String {
        return "http://intweb24.ru:49176/api/v1/"
    }
    
    var path: String {
        switch self {
        case .authUser: return "auth"
        case .registration: return "registration"
        case .createNewDevice: return "create_device"
        case . changeUserDevice: return "change_device"
        case .deleteUserDevice: return "delete_device"
        case .getUserProfileInfo: return "profile"
        case .getUserDevicesInfo: return "get_device"
        case .getCurrentWeather: return "current_metric"
        case .getDayWeatherMetrics: return "day_metrics"
        case .getWeekWeatherMetrics: return "week_metrics"
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .authUser: return [:]
        case .registration: return [:]
        default:
            return ["Authorization": userDefaults.object(forKey: "Authorization") as! String]
        }
    }
    
    var queryItems: [String: String] {
        switch self {
        case .getCurrentWeather: return ["token": userDefaults.object(forKey: "token") as? String ?? "deviceToken"]
        case .getDayWeatherMetrics: return ["token": userDefaults.object(forKey: "token") as? String ?? "deviceToken"]
        case .getWeekWeatherMetrics: return ["token": userDefaults.object(forKey: "token") as? String ?? "deviceToken"]
        default:
            return ["": ""]
        }
    }
    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseURL)!)!
        
        var urlConponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let urlQueryItems = [URLQueryItem(name: self.queryItems.keys.first!, value: self.queryItems.values.first)]
        urlConponents?.queryItems = urlQueryItems
        
        var request = URLRequest(url: (urlConponents?.url)!)
        
        request.allHTTPHeaderFields = headers
        
        switch self {
        case .authUser:
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            return request
        case .registration:
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            return request
        case .createNewDevice:
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            return request
        case .deleteUserDevice:
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "DELETE"
            return request
        case .changeUserDevice:
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "PUT"
            return request
        default:
            request.httpMethod = "GET"
            request.setValue(headers.keys.first, forHTTPHeaderField: headers.values.first!)
            return request
        }
    }
}

class ApiManager {
    
    static let shared = ApiManager()
    
    func authUser(httpBodyParametrs: Data, completion: @escaping (UserAuth) -> Void) {
        var request = ApiType.authUser.request
        request.httpBody = httpBodyParametrs
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data, let userAuth = try? JSONDecoder().decode(UserAuth.self, from: data) {
                completion(userAuth)
            }
        }
        task.resume()
    }
    
    func registrationUser(httpBodyParametrs: Data, completion: @escaping (UserRegistration) -> Void) {
        var request = ApiType.registration.request
        request.httpBody = httpBodyParametrs
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let userRegistration = try? JSONDecoder().decode(UserRegistration.self, from: data) {
                completion(userRegistration)
            }
        }
        task.resume()
    }
    
    func createNewDevice(httpBodyParametrs: Data, completion: @escaping (CreatedDevice) -> Void) {
        var request = ApiType.createNewDevice.request
        request.httpBody = httpBodyParametrs
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let createdDevice = try? JSONDecoder().decode(CreatedDevice.self, from: data) {
                completion(createdDevice)
            }
        }
        task.resume()
    }
    
    func changeUserDevice(httpBodyParametrs: Data, completion: @escaping (ChangeDevice) -> Void) {
        var request = ApiType.changeUserDevice.request
        request.httpBody = httpBodyParametrs
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let changedDevice = try? JSONDecoder().decode(ChangeDevice.self, from: data) {
                completion(changedDevice)
            }
        }
        task.resume()
    }
    
    
    func deleteUserDevice(httpBodyParametrs: Data, completion: @escaping (UserDeviceDelete) -> Void) {
        var request = ApiType.deleteUserDevice.request
        request.httpBody = httpBodyParametrs
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let deletedDevice = try? JSONDecoder().decode(UserDeviceDelete.self, from: data) {
                completion(deletedDevice)
            }
        }
        task.resume()
    }
    
    func getUserProfileInfo(completion: @escaping (UserProfileInfo) -> Void) {
        let request = ApiType.getUserProfileInfo.request
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data, let userProfileInfo = try? JSONDecoder().decode(UserProfileInfo.self, from: data) {
                completion(userProfileInfo)
            }
        }
        task.resume()
    }
    
    func getUserDevicesInfo(completion: @escaping (UserDevicesInfo) -> Void) {
        let request = ApiType.getUserDevicesInfo.request
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data, let userDevicesInfo = try? JSONDecoder().decode(UserDevicesInfo.self, from: data) {
                completion(userDevicesInfo)
            }
        }
        task.resume()
    }
    
    func getCurrentWeather(completion: @escaping (CurrentWeather) -> Void) {
        let request = ApiType.getCurrentWeather.request
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data, let currentWeather = try? JSONDecoder().decode(CurrentWeather.self, from: data) {
                completion(currentWeather)
            }
        }
        task.resume()
    }
    
    func getDayWeatherMetrics(completion: @escaping (DayWeather) -> Void) {
        let request = ApiType.getDayWeatherMetrics.request
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data, let dayWeatherMetrics = try? JSONDecoder().decode(DayWeather.self, from: data) {
                completion(dayWeatherMetrics)
            }
        }
        task.resume()
    }
    
    func getWeekWeatherMetrics(completion: @escaping (WeekWeather) -> Void) {
        let reques = ApiType.getWeekWeatherMetrics.request
        let task = URLSession.shared.dataTask(with: reques) { data, responce, error in
            if let data = data, let weekWeatherMetrics = try? JSONDecoder().decode(WeekWeather.self, from: data) {
                completion(weekWeatherMetrics)
            }
        }
        task.resume()
    }
    
}
