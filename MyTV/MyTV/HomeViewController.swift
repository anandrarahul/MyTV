//
//  HomeViewController.swift
//  MyTV
//
//  Created by Rahul Anand on 19/12/23.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("home.title", comment: "")
    }

}
