//
//  CustomTextField.swift
//  JatApp
//
//  Created by Iryna Kopchynska on 14.08.2020.
//  Copyright © 2020 Iryna Kopchynska. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField: UITextField, UITextFieldDelegate {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        createBorder()
    }
    
    func createBorder(){
        self.layer.borderColor = UIColor.greenButtonColor.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
}
