//
//  AutentificationViewModel.swift
//  JatApp
//
//  Created by Iryna Kopchynska on 24.08.2020.
//  Copyright © 2020 Iryna Kopchynska. All rights reserved.
//

import Foundation
import UIKit

class AutentificationViewModel {
    
    private var logIn = LoginAccount()
    private var signIn = CreateAccount()

    func loginToAccount(_ email: String, _ password: String) {
            logIn.logIn(email: email, password: password, completionHandler: { (response, error) in
                DispatchQueue.main.async {
                    self.checkResponse(error : error, response: response)
                }
            })
        }
        
        func createNewAccount(_ name: String, _ email: String, _ password: String) {
            signIn.signUp(name: name, email: email, password: password, completionHandler: { (response, error) in
                DispatchQueue.main.async {
                    self.checkResponse(error: error, response: response)
                }
            })
        }

    private func checkResponse(error: Error?, response : LoginSignupModel?) {
            if let error = error {
                print(error)
                self.alertMessage(message: ErrorMessege.error.rawValue)
                return
            }
            
            if let respon = response {
                if respon.success {
                    DataStorege.shared.token = response?.data.access_token
                } else {
                    for message in respon.errors {
                        if let message = message.message {
                            alertMessage(message: message)
                        }
                    }
                }
            }
        }
    
    func alertMessage(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default , handler: nil)
        
        alertController.addAction(action)
    }
}
