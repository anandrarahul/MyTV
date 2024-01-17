//
//  AccountDetailsViewController.swift
//  MyTV
//
//  Created by Rahul Anand on 17/01/24.
//

import UIKit

class AccountDetailsViewController: UIViewController {

    @IBOutlet weak var detailsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setTitleAndDescription(title: String, description: String) {
        self.navigationController?.navigationBar.topItem?.title = title
//        self.detailsLabel.text = description
    }

}
