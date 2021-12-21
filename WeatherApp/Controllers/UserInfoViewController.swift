//
//  UserInfoViewCOntroller.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 19.12.2021.
//

import Foundation
import UIKit

class UserInfoViewController: UIViewController {
    
    var currentUserDevices: [UserDevice] = []
    
    @IBOutlet var tableView: UITableView!

    @IBOutlet var userName: UILabel!
    @IBOutlet var userSurname: UILabel!
    @IBOutlet var userPatronymic: UILabel!
    
    @IBAction func showMainWindowViewController() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainWindowViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainWindow")
        mainWindowViewController.modalTransitionStyle = .coverVertical
        mainWindowViewController.modalPresentationStyle = .overFullScreen
        self.present(mainWindowViewController, animated: true, completion: nil)
    }
    
    @IBAction func showCreateNewDeviceAllert() {
        let alertController = UIAlertController(title: "Создайте устройство", message: "Введите имя:", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { textField in textField.placeholder = "Имя"})
        
        let createNewDeviceButton = UIAlertAction(title: "Создать", style: .default) {_ in
            guard let deviceName = alertController.textFields?[0].text else {
                return
            }
            let deviceData = ["name": deviceName]
            let httpDeviceData = try? JSONSerialization.data(withJSONObject: deviceData, options: [])
            self.createNewDevice(httpBodyParametrs: httpDeviceData!)
        }
        
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        alertController.addAction(createNewDeviceButton)
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserProfile()
        self.getUserDevicesInfo()
    }
    
    private func createNewDevice(httpBodyParametrs: Data) {
        ApiManager.shared.createNewDevice(httpBodyParametrs: httpBodyParametrs) { createdDevice in
            DispatchQueue.main.async {
                if createdDevice.success == true {
                    self.showQueryResultAllert(allertText: "Устройство было успешно создано")
                    //                    self.getUserDevicesInfo()
                    self.currentUserDevices.append(UserDevice(
                        deviceName: (createdDevice.data?.name)!,
                        deviceToken: (createdDevice.data?.tokenDevice)!))
                    self.tableView.reloadData()
                } else if createdDevice.success == false {
                    self.showQueryResultAllert(allertText: (createdDevice.error?.message)!)
                }
            }
        }
    }
    
    private func showQueryResultAllert(allertText: String) {
        let allertController = UIAlertController(
            title: "Управление устройствами",
            message: allertText,
            preferredStyle: .alert
        )
        
        let actionOK = UIAlertAction(
            title: "Ок",
            style: .default,
            handler: nil
        )
        
        allertController.addAction(actionOK)
        present(allertController, animated: true, completion: nil)
    }
    
    private func getUserProfile() {
        ApiManager.shared.getUserProfileInfo{ currentUserPrifileInfo in
            let currentUserName = String((currentUserPrifileInfo.data?.name)!)
            let currentUserSurname = String((currentUserPrifileInfo.data?.surname)!)
            let currentUserPatronymic = String((currentUserPrifileInfo.data?.patronymic)!)
            DispatchQueue.main.async {
                self.updateCurrentUserPrifilInfoLabelText(sender: self.userName, newData: currentUserName)
                self.updateCurrentUserPrifilInfoLabelText(sender: self.userSurname, newData: currentUserSurname)
                self.updateCurrentUserPrifilInfoLabelText(sender: self.userPatronymic, newData: currentUserPatronymic)
            }
        }
    }
    
    private func updateCurrentUserPrifilInfoLabelText(sender: UILabel, newData: String) {
        sender.text! = newData
    }
    
    func getUserDevicesInfo() {
        ApiManager.shared.getUserDevicesInfo{ currentUserDevicesInfo in
            DispatchQueue.main.async {
                currentUserDevicesInfo.data?.devices?.forEach{ device in
                    self.currentUserDevices.append(UserDevice(deviceName: device.name!, deviceToken: device.token!))
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func showChangeUserDeviceAllert(deviceToken: String){
        let alertController = UIAlertController(title: "Изменение устройства", message: "Введите новое имя:", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { textField in textField.placeholder = "Имя"})
        
        let changeUserDeviceButton = UIAlertAction(title: "Изменить", style: .default) {_ in
            guard let deviceName = alertController.textFields?[0].text else {
                return
            }
            let deviceData = ["name": deviceName, "token": deviceToken]
            self.changeUserDevice(httpBodyParametrs: deviceData)
            
        }
        
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        alertController.addAction(changeUserDeviceButton)
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true, completion: nil)
        
    }

    
    func changeUserDevice(httpBodyParametrs: [String: String]){
        let httpBodyParametrs = try? JSONSerialization.data(withJSONObject: httpBodyParametrs, options: [])
        ApiManager.shared.changeUserDevice(httpBodyParametrs: httpBodyParametrs!){ changedDevice in
            DispatchQueue.main.async {
                if changedDevice.success == true {
                    self.showQueryResultAllert(allertText: "Имя устройства успешно изменено")
                } else if changedDevice.success == false {
                    self.showQueryResultAllert(allertText: (changedDevice.error?.message)!)
                }
            }
        }
    }
    
    func deleteUserDevice(httpBodyParametrs: [String: String]){
        let httpBodyParametrs = try? JSONSerialization.data(withJSONObject: httpBodyParametrs, options: [])
        ApiManager.shared.deleteUserDevice(httpBodyParametrs: httpBodyParametrs!){ deletedDevice in
            DispatchQueue.main.async {
                if deletedDevice.success == true {
                    self.showQueryResultAllert(allertText: (deletedDevice.data?.message)!)
                } else if deletedDevice.success == false {
                    self.showQueryResultAllert(allertText: (deletedDevice.error?.message)!)
                }
            }
        }
    }
}
