//
//  RegistrationViewController.swift
//  WeatherApp
//
//  Created by Pavel Yarovoi on 30.11.2021.
//

import Foundation
import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var username: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var surname: UITextField!
    @IBOutlet var patronymic: UITextField!
    @IBOutlet var firstPassword: UITextField!
    @IBOutlet var secondPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.username.delegate = self
        self.name.delegate = self
        self.surname.delegate = self
        self.patronymic.delegate = self
        self.firstPassword.delegate = self
        self.secondPassword.delegate = self
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
    
    @IBAction func registerNewUser() {
        guard let username = username.text, !username.isEmpty else { return }
        guard let name = name.text, !name.isEmpty else { return }
        guard let surname = surname.text, !surname.isEmpty else { return }
        guard let patronymic = patronymic.text, !patronymic.isEmpty else { return }
        guard let firstPassword = firstPassword.text, !firstPassword.isEmpty else { return }
        guard let secondPassword = secondPassword.text, !secondPassword.isEmpty else { return }
        
        let bodyParametrs = [
            "username": username,
            "name": name,
            "surname": surname,
            "patronymic": patronymic,
            "password_1": firstPassword,
            "password_2": secondPassword
        ]
        
        let httpBodyParametrs = try? JSONSerialization.data(withJSONObject: bodyParametrs, options: [])
        
        ApiManager.shared.registrationUser(httpBodyParametrs: httpBodyParametrs!) {
            registerUser in
            DispatchQueue.main.async {
                if registerUser.success == true {
                    
                    guard let successMessage = registerUser.data?.message,
                          !successMessage.isEmpty else { return }
                    self.showRegistrationAllert(allertText: successMessage, success: true)
                    
                } else if registerUser.success == false {
                    
                    guard let errorMessage = registerUser.error?.message,
                          !errorMessage.isEmpty else { return }
                    self.showRegistrationAllert(allertText: errorMessage, success: false)
                   
                }
            }
        }
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.surname:
            self.name.becomeFirstResponder()
        case self.name:
            self.patronymic.becomeFirstResponder()
        case self.patronymic:
            self.username.becomeFirstResponder()
        case self.username:
            self.firstPassword.becomeFirstResponder()
        case self.firstPassword:
            self.secondPassword.becomeFirstResponder()
        default:
            self.secondPassword.resignFirstResponder()
            self.registerNewUser()
        }
    }
    
    private func showAuthViewController() {
        let authStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let authWindowViewController = authStoryboard.instantiateViewController(withIdentifier: "RegistrationWindow")
        authWindowViewController.modalTransitionStyle = .crossDissolve
        authWindowViewController.modalPresentationStyle = .overFullScreen
        self.present(authWindowViewController, animated: true, completion: nil)
    }
    
    private func showRegistrationAllert(allertText: String, success: Bool) {
        let allertController = UIAlertController(
        title: "Регистрация",
        message: allertText,
        preferredStyle: .alert
        )
        
        let actionOK = UIAlertAction(
            title: "Ок",
            style: .default,
            handler: { (action) in
                if success == true {
                    self.dismiss(animated: true, completion: nil)
                } else if success == false {
                    return
                }
            }
        )
        
        allertController.addAction(actionOK)
        present(allertController, animated: true, completion: nil)
    }
}
