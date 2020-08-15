//
//  TextModel.swift
//  JatApp
//
//  Created by Iryna Kopchynska on 12.08.2020.
//  Copyright © 2020 Iryna Kopchynska. All rights reserved.
//

import Foundation
import UIKit

struct TextModel: Decodable {
    let success: Bool
    let data: String?
    let errors: [ErrorModel]?
}
