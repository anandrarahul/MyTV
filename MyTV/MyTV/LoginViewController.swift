//
//  LoginViewController.swift
//  MyTV
//
//  Created by Rahul Anand on 24/10/23.
//

import UIKit

typealias LoginAlertCallback = (String) -> Void

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var loginSubTitle: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var copyRightLabel: UILabel!
    @IBOutlet weak var loginImageView: UIImageView!
    
    var loginAlertCallback: LoginAlertCallback?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.title = NSLocalizedString("Application.Title", comment: "app name")
        self.loginImageView.image = UIImage(named: "matchingMovie")
        self.loginTitle.text = NSLocalizedString("Login.Title", comment: "login")
        self.loginSubTitle.text = NSLocalizedString("Login.SubTitle", comment: "login subtitle")
        self.copyRightLabel.text = NSLocalizedString("CopyRight.Title", comment: "Copy right")
        self.usernameTextField.placeholder = NSLocalizedString("Username.Title", comment: "enter username")
        self.passwordTextField.placeholder = NSLocalizedString("Password.Title", comment: "enter password")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func handleTap() {
        self.view.endEditing(true)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3) {
                if self.usernameTextField.isFirstResponder {
                    self.view.frame.origin.y = 0
                    self.view.frame.origin.y = -(keyboardSize.height / 2)
                }
                if self.passwordTextField.isFirstResponder {
                    self.view.frame.origin.y = 0
                    self.view.frame.origin.y = -(keyboardSize.height / 2 + 40)
                }
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let username = self.usernameTextField.text, !username.isEmpty,
              let password = self.passwordTextField.text, !password.isEmpty else {
            self.showAlert(message: "Please enter both username and password.")
            return
        }
        if isValidCredentials(username: username, password: password) {
            self.usernameTextField.text = ""
            self.passwordTextField.text = ""
            let mainNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
            mainNavigationController.modalPresentationStyle = .fullScreen
            self.present(mainNavigationController, animated: true)
        } else {
            self.showAlert(message: "Invalid username or password. Please try again.")
        }
    }
    
    func isValidCredentials(username: String, password: String) -> Bool {
        let validUsername = "a"
        let validPassword = "a"
        return username == validUsername && password == validPassword
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        self.loginAlertCallback?(message)
    }
}
