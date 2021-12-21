//
//  UserDevices.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 21.12.2021.
//

import Foundation

protocol UserDeviceProtocol {
    var deviceName: String { get set }
    var deviceToken: String { get set }
    
    subscript(index:String) -> Any { get }

}

struct UserDevice: UserDeviceProtocol {
    var deviceName: String
    var deviceToken: String
    
    subscript(index:String) -> Any {
            get {
                return self.deviceName
            }
        }
}
