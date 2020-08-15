//
//  CreateAccount.swift
//  JatApp
//
//  Created by Iryna Kopchynska on 12.08.2020.
//  Copyright © 2020 Iryna Kopchynska. All rights reserved.
//

import Foundation
import UIKit

class CreateAccount {
    
    let singupURL =  "https://apiecho.cf/api/signup/"
    
    var signUp: LoginSignupModel?
    
    func signUp(name: String, email: String, password: String, completionHandler: @escaping (LoginSignupModel?, Error?) -> Void) {
        
        guard let url = URL(string: singupURL) else { return }
        
        var request = URLRequest(url: url)
        let parameters = ["name" : name, "email" : email, "password" : password]
        
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
                self.signUp = try JSONDecoder().decode(LoginSignupModel.self, from: data)
                completionHandler(self.signUp, nil)
            } catch {
                completionHandler(nil, error)
            }
        }.resume()
    }
}
