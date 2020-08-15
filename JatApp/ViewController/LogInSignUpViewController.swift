//
//  LogInSignUpViewController.swift
//  JatApp
//
//  Created by Iryna Kopchynska on 13.08.2020.
//  Copyright © 2020 Iryna Kopchynska. All rights reserved.
//
import Foundation
import UIKit

class LogInSignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var welcomelabel: UILabel!
    @IBOutlet var textWelcomeLabel: UILabel!
    @IBOutlet var nameTextField: CustomTextField!
    @IBOutlet var emailTextField: CustomTextField!
    @IBOutlet var passwordTextField: CustomTextField!
    @IBOutlet var passwordRepeatTextField: CustomTextField!
    @IBOutlet var createButton: UIButton!
    @IBOutlet var switchButton: UISegmentedControl!
    @IBOutlet weak var viewIndicator: CustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createButton.backgroundColor = UIColor.greenButtonColor
        createButton.setTitleColor(UIColor.white, for: .normal)
        createButton.layer.cornerRadius = 15
        createButton.clipsToBounds = true
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        switchButton.backgroundColor = UIColor.greenButtonColor
        switchButton.layer.borderColor = UIColor.greenButtonColor.cgColor
        switchButton.selectedSegmentTintColor = UIColor.white
        switchButton.layer.borderWidth = 1
        switchButton.layer.cornerRadius = 5
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        switchButton.setTitleTextAttributes(titleTextAttributes, for:.normal)
        
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.greenButtonColor]
        switchButton.setTitleTextAttributes(titleTextAttributes1, for:.selected)
        
        viewIndicator.stopActivity()
    }
    
    var logIn = LoginAccount()
    var signIn = CreateAccount()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func checkResponse(error: Error?, response : LoginSignupModel?) {
        viewIndicator.startActivity()
        if let error = error {
            print(error)
            self.createButton.isEnabled = true
            viewIndicator.stopActivity()
            self.alertMessage(message: ErrorMessege.error.rawValue)
            return
        }
        
        if let respon = response {
            if respon.success {
                DataStorege.shared.token = response?.data.access_token
                self.performSegue(withIdentifier: "results", sender: self)
            } else {
                self.createButton.isEnabled = true
                viewIndicator.stopActivity()
                for message in respon.errors {
                    if let message = message.message {
                        viewIndicator.stopActivity()
                        alertMessage(message: message)
                    }
                }
            }
        }
    }
    
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
    
    @IBAction func switchButton(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            nameTextField.isHidden = false
            passwordRepeatTextField.isHidden = false
            passwordTextField.text = nil
            emailTextField.text = nil
            nameTextField.text = nil
            passwordRepeatTextField.text = nil
            createButton.setTitle("Sign In", for: .normal)
            welcomelabel.text = "Welcome!"
            textWelcomeLabel.text = "Create your account to view all features"
        case 1:
            nameTextField.isHidden = true
            passwordRepeatTextField.isHidden = true
            passwordTextField.text = nil
            emailTextField.text = nil
            createButton.setTitle("Log In", for: .normal)
            welcomelabel.text = "Welcome!"
            textWelcomeLabel.text = "Nice to see you again"
        default:
            break
        }
    }
    
    private enum LocalConstant {
        static let minPasswordLength = 5
        static let minNameLength = 3
    }
    
    
    @IBAction func createNewAccountButton(_ sender: UIButton) {
        
        let userName = nameTextField.text ?? ""
        let userEmail = emailTextField.text ?? ""
        let userPassword = passwordTextField.text ?? ""
        let userConfirmPassword = passwordRepeatTextField.text ?? ""
        
        if (userName.isEmpty && userPassword.isEmpty && userConfirmPassword.isEmpty) {
            alertMessage(message: ErrorMessege.emptyFields.rawValue)
        }
        if (userPassword.isEmpty && userConfirmPassword.isEmpty) {
            alertMessage(message: ErrorMessege.setPassword.rawValue)
        }
        if (!userName.isEmpty && userName.count < LocalConstant.minNameLength) {
            alertMessage(message: ErrorMessege.moreName.rawValue)
        }
        if (!userPassword.isEmpty && userPassword.count < LocalConstant.minPasswordLength) {
            alertMessage(message: ErrorMessege.morePassword.rawValue)
        }
        if (!userPassword.isEmpty && userConfirmPassword.isEmpty) {
            alertMessage(message: ErrorMessege.confirmPassword.rawValue)
        }
        if (userPassword != userConfirmPassword ) {
            alertMessage(message: ErrorMessege.notMatch.rawValue)
        }
        
        createButton.isEnabled = false
        viewIndicator.startActivity()
        
        if switchButton.selectedSegmentIndex == 0 {
            createNewAccount(userName, userEmail, userPassword)
        } else if switchButton.selectedSegmentIndex == 1 {
            loginToAccount(userEmail, userPassword)
        }
    }
    
    func alertMessage(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default , handler: nil)
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
