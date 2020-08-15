//
//  ErrorModel.swift
//  JatApp
//
//  Created by Iryna Kopchynska on 12.08.2020.
//  Copyright © 2020 Iryna Kopchynska. All rights reserved.
//

import Foundation
import UIKit

struct ErrorModel: Decodable {
    let name: String?
    let message: String?
    let code: Int?
    let status: Int?
}
