//
//  LoginSignupModel.swift
//  JatApp
//
//  Created by Iryna Kopchynska on 12.08.2020.
//  Copyright © 2020 Iryna Kopchynska. All rights reserved.
//

import Foundation
import UIKit

struct LoginSignupModel: Decodable {
    let success: Bool
    let data: Data
    let errors: [ErrorModel]
}

struct Data: Decodable {
    let uid: Int?
    let name: String?
    let email: String?
    let access_token: String?
    let role: Int?
    let status: Int?
    let created_at: Int?
    let updated_at: Int?
}
