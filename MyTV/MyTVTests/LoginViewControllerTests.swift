//
//  LoginViewControllerTests.swift
//  MyTVTests
//
//  Created by Rahul Anand on 17/01/24.
//

import XCTest
@testable import MyTV

final class LoginViewControllerTests: XCTestCase {

    var loginViewController: LoginViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        self.loginViewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        self.loginViewController = nil
        try super.tearDownWithError()
    }

    func testLoginButtonTapped() throws {
        let mockNavigationController = MockNavigationController()
        UIApplication.shared.keyWindow?.rootViewController = mockNavigationController
        
        self.loginViewController.loginButtonTapped(UIButton())
        
        XCTAssertEqual(mockNavigationController.modalPresentationStyle, .fullScreen)
        XCTAssertTrue(mockNavigationController.presentingViewController is LoginViewController)
    }
    
    func testViewDidLoad() throws {
        self.loginViewController.viewDidLoad()
        XCTAssertEqual(self.loginViewController.navigationController?.title, NSLocalizedString("Application.Title", comment:""))
        XCTAssertEqual(self.loginViewController.loginTitle.text, NSLocalizedString("Login.Title", comment: ""))
        XCTAssertEqual(self.loginViewController.loginSubTitle.text, NSLocalizedString("Login.SubTitle", comment: ""))
        XCTAssertEqual(self.loginViewController.copyRightLabel.text, NSLocalizedString("CopyRight.Title", comment: ""))
        XCTAssertEqual(self.loginViewController.usernameTextField.placeholder, NSLocalizedString("Username.Title", comment: ""))
        XCTAssertEqual(self.loginViewController.passwordTextField.placeholder, NSLocalizedString("Password.Title", comment: ""))
    }

}
