//
//  ResultsTableViewController.swift
//  JatApp
//
//  Created by Iryna Kopchynska on 13.08.2020.
//  Copyright © 2020 Iryna Kopchynska. All rights reserved.
//

import UIKit
import Foundation

class ResultsTableViewController: UITableViewController {
    
    @IBOutlet var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        textDataRequest()
        
        let nib = UINib(nibName: "\(HeaderTableViewCell.self)", bundle: nil)
        self.tableView.register(nib, forHeaderFooterViewReuseIdentifier: "HeaderTableViewCell")
        
        self.navigationController?.navigationBar.topItem?.hidesBackButton = true
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.greenButtonColor]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        
        logOutButton.backgroundColor = UIColor.greenButtonColor
        logOutButton.setTitleColor(UIColor.white, for: .normal)
        logOutButton.layer.cornerRadius = 15
        logOutButton.clipsToBounds = true
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        return headerCell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    var textResults = TextResults()
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textResults.charArr.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell") as! ResultTableViewCell
        cell.view.backgroundColor = UIColor.cellColor
        
        let name : String = String(textResults.charArr[indexPath.row])
        print(name)
        if let number = textResults.dict[textResults.charArr[indexPath.row]] {
            
            if name == " " {
                cell.nameLabel.text = "Space"
                cell.numberLabel.text = "\(number) times"
            } else {
                cell.nameLabel.text = "\(name)"
                cell.numberLabel.text = "\(number) times"
            }
        }
        
        return cell
    }
    
    let textRequest = TextRequest()
    
    func textDataRequest() {
        textRequest.textRequest { (response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    self.alertMessage(message: ErrorMessege.error.rawValue)
                    return
                }
                if let response = response {
                    if let text = response.data {
                        self.textResults.countAlpha(text: text)
                        self.tableView.reloadData()
                        
                    }
                }
            }
        }
    }
    
    func alertMessage(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default , handler: nil)
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
