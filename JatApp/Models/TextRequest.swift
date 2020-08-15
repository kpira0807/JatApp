//
//  TextRequest.swift
//  JatApp
//
//  Created by Iryna Kopchynska on 13.08.2020.
//  Copyright © 2020 Iryna Kopchynska. All rights reserved.
//

import Foundation
import UIKit

class TextRequest {
    
    let textURL = "https://apiecho.cf/api/get/text/"
    
    var textResult: LoginSignupModel?
    
    func textRequest(completionHandler: @escaping (TextModel?, Error?) -> Void) {
        guard let newToken = DataStorege.shared.token else { return }
        guard let url = URL(string: textURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("Bearer \(newToken)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            do {
                let jsonResponse = try JSONDecoder().decode(TextModel.self, from: data)
                completionHandler(jsonResponse, nil)
            } catch {
                completionHandler(nil, error)
            }
        }.resume()
    }
}
