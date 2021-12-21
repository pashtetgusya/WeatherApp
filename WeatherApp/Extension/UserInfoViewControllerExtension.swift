//
//  UserInfoViewControllerExtension.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 21.12.2021.
//

import Foundation
import UIKit

extension UserInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUserDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var newTableCell: UITableViewCell
        if let reuseTableCell = tableView.dequeueReusableCell(withIdentifier: "devicesCellIdentifer ") {
            newTableCell = reuseTableCell
        } else {
            newTableCell = UITableViewCell(style: .default, reuseIdentifier: "devicesCellIdentifer ")
        }
        tableCellConfigure(tableCell: &newTableCell, for: indexPath)
        newTableCell.backgroundColor = UIColor.gray
        return newTableCell
    }
    
    private func tableCellConfigure(tableCell: inout UITableViewCell, for indexPath: IndexPath) {
        var cellConfiguration = tableCell.defaultContentConfiguration()
        cellConfiguration.text = currentUserDevices[indexPath.row].deviceName
        cellConfiguration.secondaryText = currentUserDevices[indexPath.row].deviceToken
        tableCell.contentConfiguration = cellConfiguration
    }
    
}

extension UserInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionSelect = UIContextualAction(style: .normal, title: "Выбрать") {_,_,_ in
            let selectedDeviceToken = self.currentUserDevices[indexPath.row].deviceToken
            userDefaults.set(selectedDeviceToken, forKey: "token")
        }
        
        let actionChande = UIContextualAction(style: .normal, title: "Изменить") {_,_,_ in
            DispatchQueue.main.async {
                let deviceToken = self.currentUserDevices[indexPath.row].deviceToken
                self.showChangeUserDeviceAllert(deviceToken: deviceToken)
            }
        }
        
        let actionDelete = UIContextualAction(style: .destructive, title: "Удалить") {_,_,_ in
            DispatchQueue.main.async {
                let httpBody = ["token": self.currentUserDevices[indexPath.row].deviceToken]
                self.deleteUserDevice(httpBodyParametrs: httpBody)
                self.currentUserDevices.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
        
        let action = UISwipeActionsConfiguration(actions: [actionSelect, actionChande,actionDelete])
        return action
    }
}
