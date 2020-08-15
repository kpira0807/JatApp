//
//  LoaderView.swift
//  JatApp
//
//  Created by Iryna Kopchynska on 14.08.2020.
//  Copyright © 2020 Iryna Kopchynska. All rights reserved.
//

import Foundation
import UIKit

class CustomView: UIView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        createBorder()
    }
    
    func createBorder(){
        self.backgroundColor = UIColor.viewColor
        self.clipsToBounds = true
    }
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    func startActivity() {
        activity.isHidden = false
        self.isHidden = false
        activity.startAnimating()
    }
    
    func stopActivity() {
        activity.isHidden = true
        self.isHidden = true
        activity.stopAnimating()
    }
}
