//
//  HeaderTableViewCell.swift
//  JatApp
//
//  Created by Iryna Kopchynska on 13.08.2020.
//  Copyright © 2020 Iryna Kopchynska. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewHeaderFooterView {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var view: UIView!
    
    static let identifier = "HeaderTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "HeaderTableViewCell",
                     bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view.backgroundColor = UIColor.headerColor
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        
    }
}
