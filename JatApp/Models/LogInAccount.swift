//
//  LogInAccount.swift
//  JatApp
//
//  Created by Iryna Kopchynska on 12.08.2020.
//  Copyright © 2020 Iryna Kopchynska. All rights reserved.
//

import Foundation
import UIKit

class LoginAccount {
   
    let logInURL = "https://apiecho.cf/api/login/"
    
    var logIn: LoginSignupModel?
    
    func logIn(email: String, password: String, completionHandler: @escaping (LoginSignupModel?, Error?) -> Void) {
        
        guard let url = URL(string: logInURL) else { return }
        
        var request = URLRequest(url: url)
        let parameters = ["email" : email, "password" : password]
        
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) {(data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            do {
                self.logIn = try JSONDecoder().decode(LoginSignupModel.self, from: data)
              
                completionHandler(self.logIn , nil)
            } catch {
                completionHandler(nil, error)
            }
        }.resume()
    }
}
