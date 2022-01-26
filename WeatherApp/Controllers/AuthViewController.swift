//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 30.11.2021.
//

import Foundation
import UIKit

class AuthViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.username.delegate = self
        self.password.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as? UITouch {
            view.endEditing(true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
    }
    
    @IBAction func authUser() {
        guard let username = username.text, !username.isEmpty else { return }
        guard let password = password.text, !password.isEmpty else { return }
        
        let bodyParametrs = ["username": username, "password": password]
        let httpBodyParametrs = try? JSONSerialization.data(withJSONObject: bodyParametrs, options: [])
        
        ApiManager.shared.authUser(httpBodyParametrs: httpBodyParametrs!) { authUser in
            DispatchQueue.main.async {
                
                if authUser.success == true {
                    
                    let userToken = "Token \(authUser.data?.token! ?? "asd")"
                    userDefaults.set(userToken, forKey: "Authorization")
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainWindowViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainWindow")
                    mainWindowViewController.modalTransitionStyle = .coverVertical
                    mainWindowViewController.modalPresentationStyle = .overFullScreen
                    self.present(mainWindowViewController, animated: true, completion: nil)
                    
                } else if authUser.success == false {
                    
                    guard let errorMessage = authUser.error?.message, !errorMessage.isEmpty else { return }
                    self.showAuthErrorAllert(allertText: errorMessage)
                    
                }
            }
        }
    }
    
    @IBAction func showRegistrationViewController() {
        let registrationStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let registrationWindowViewController = registrationStoryboard.instantiateViewController(withIdentifier: "RegistrationWindow")
        registrationWindowViewController.modalTransitionStyle = .crossDissolve
        registrationWindowViewController.modalPresentationStyle = .overFullScreen
        self.present(registrationWindowViewController, animated: true, completion: nil)
    }
    
    private func switchBasedNextTextField(_ textFiled: UITextField) {
        switch textFiled {
        case self.username:
            self.password.becomeFirstResponder()
        default:
            self.password.resignFirstResponder()
            self.authUser()
        }
    }
    
    private func showAuthErrorAllert(allertText: String) {
        let allertController = UIAlertController(
            title: "Ошибка авторизации",
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
    
    private func showAuthAllert(allertText: String) {
        let allertController = UIAlertController(
            title: "Авторизация",
            message: allertText,
            preferredStyle: .alert
        )
        
        let actionOK = UIAlertAction(
            title: "Ок",
            style: .default,
            handler: { (action) in
                self.dismiss(animated: true, completion: nil)
                
            }
        )
        
        allertController.addAction(actionOK)
        present(allertController, animated: true, completion: nil)
    }
    
}
