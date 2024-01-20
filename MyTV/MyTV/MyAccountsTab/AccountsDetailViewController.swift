//
//  AccountsDetailViewController.swift
//  MyTV
//
//  Created by Rahul Anand on 20/01/24.
//

import UIKit

class AccountsDetailViewController: UIViewController {

    @IBOutlet weak var descriptionTextLabel: UILabel!
    
    var accountsTitle: String?
    var accountsDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = accountsTitle
        self.descriptionTextLabel.text = accountsDescription
    }
    
    func setTitleAndDescription(title: String, description: String) {
        self.accountsTitle = title
        self.accountsDescription = description
    }

}
