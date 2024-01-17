//
//  LoginViewController.swift
//  MyTV
//
//  Created by Rahul Anand on 24/10/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var loginSubTitle: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var copyRightLabel: UILabel!
    
    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        let mainNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
        mainNavigationController.modalPresentationStyle = .fullScreen
        self.present(mainNavigationController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = NSLocalizedString("Application.Title", comment: "app name")
        self.loginTitle.text = NSLocalizedString("Login.Title", comment: "login")
        self.loginSubTitle.text = NSLocalizedString("Login.SubTitle", comment: "login subtitle")
        self.copyRightLabel.text = NSLocalizedString("CopyRight.Title", comment: "Copy right")
        self.usernameTextField.placeholder = NSLocalizedString("Username.Title", comment: "enter username")
        self.passwordTextField.placeholder = NSLocalizedString("Password.Title", comment: "enter password")
    }

}

