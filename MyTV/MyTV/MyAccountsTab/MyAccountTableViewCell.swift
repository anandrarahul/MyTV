//
//  MyAccountTableViewCell.swift
//  MyTV
//
//  Created by Rahul Anand on 16/01/24.
//

import UIKit

class MyAccountTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    
    func setTitleForCell(title: String, accessoryType: UITableViewCell.AccessoryType? = UITableViewCell.AccessoryType.none) {
        self.cellTitle.text = title
        guard let accessoryType = accessoryType else {
            print("No accessoryType for MyAccountTableViewCell is provided")
            return
        }
        self.accessoryType = accessoryType
    }

}
