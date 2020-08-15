//
//  ResultTableViewCell.swift
//  JatApp
//
//  Created by Iryna Kopchynska on 13.08.2020.
//  Copyright © 2020 Iryna Kopchynska. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
    }

}
