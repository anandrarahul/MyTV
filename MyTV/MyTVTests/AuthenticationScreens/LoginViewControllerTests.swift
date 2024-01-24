//
//  LoginViewControllerTests.swift
//  MyTVTests
//
//  Created by Rahul Anand on 17/01/24.
//

import XCTest
@testable import MyTV

final class LoginViewControllerTests: XCTestCase {
    
    var viewController: LoginViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        viewController.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        viewController = nil
    }
    
    func testOutletsNotNil() {
        XCTAssertNotNil(viewController.loginTitle)
        XCTAssertNotNil(viewController.loginSubTitle)
        XCTAssertNotNil(viewController.usernameTextField)
        XCTAssertNotNil(viewController.passwordTextField)
        XCTAssertNotNil(viewController.copyRightLabel)
        XCTAssertNotNil(viewController.loginImageView)
    }
    
    func testViewDidLoad() {
        viewController.viewDidLoad()
        XCTAssertNotNil(viewController.loginImageView.image)
        XCTAssertEqual(viewController.loginTitle.text, NSLocalizedString("Login.Title", comment: "login"))
        XCTAssertEqual(viewController.loginSubTitle.text, NSLocalizedString("Login.SubTitle", comment: "login subtitle"))
        XCTAssertEqual(viewController.copyRightLabel.text, NSLocalizedString("CopyRight.Title", comment: "Copy right"))
        XCTAssertEqual(viewController.usernameTextField.placeholder, NSLocalizedString("Username.Title", comment: "enter username"))
        XCTAssertEqual(viewController.passwordTextField.placeholder, NSLocalizedString("Password.Title", comment: "enter password"))
    }
    
    func testHandleTap() {
        viewController.handleTap()
        
        XCTAssertFalse(viewController.usernameTextField.isFirstResponder)
        XCTAssertFalse(viewController.passwordTextField.isFirstResponder)
    }
    
//    func testKeyboardWillShowForUserName() {
//        XCTAssertEqual(viewController.view.frame.origin.y, 0)
//        let usernameNotification = Notification(name: UIResponder.keyboardWillShowNotification, object: nil, userInfo: [
//            UIResponder.keyboardFrameEndUserInfoKey: NSValue(cgRect: CGRect(x: 0, y: 0, width: 320, height: 216))
//        ])
//        viewController.usernameTextField.becomeFirstResponder()
//        viewController.keyboardWillShow(usernameNotification)
//        
//        XCTAssertTrue(viewController.usernameTextField.isFirstResponder)
//        XCTAssertEqual(viewController.view.frame.origin.y, -(216 / 2))
//    }
//
//    func testKeyboardWillShowForPassword() {
//
//        XCTAssertEqual(viewController.view.frame.origin.y, 0)
//        let passwordNotification = Notification(name: UIResponder.keyboardWillShowNotification, object: nil, userInfo: [
//            UIResponder.keyboardFrameEndUserInfoKey: NSValue(cgRect: CGRect(x: 0, y: 0, width: 320, height: 216))
//        ])
//        viewController.passwordTextField.becomeFirstResponder()
//        viewController.keyboardWillShow(passwordNotification)
//
//        XCTAssertTrue(viewController.passwordTextField.isFirstResponder)
//        XCTAssertEqual(viewController.view.frame.origin.y, -(216 / 2 + 40))
//    }
    
    func testKeyboardWillHide() {
        let notification = Notification(name: UIResponder.keyboardWillHideNotification,
                                        object: nil,
                                        userInfo: [UIResponder.keyboardFrameEndUserInfoKey: NSValue(cgRect: CGRect(x: 0, y: 0, width: 0, height: 200))])
        
        viewController.keyboardWillHide(notification)
        
        XCTAssertEqual(viewController.view.frame.origin.y, 0)
    }
    
    func testLoginButtonTappedWithValidCredentials() {
        viewController.usernameTextField.text = "a"
        viewController.passwordTextField.text = "a"
        
        viewController.loginButtonTapped(UIButton())
        
        XCTAssertNil(viewController.presentedViewController)
    }
    
    func testLoginButtonTappedWithValidFields() {
        let expectation = XCTestExpectation(description: "No alert should be shown")
        viewController.usernameTextField.text = "invalid"
        viewController.passwordTextField.text = "wrong"
        viewController.loginAlertCallback = { message in
            XCTAssertEqual(message, "Invalid username or password. Please try again.")
        }
        viewController.loginButtonTapped(UIButton())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoginButtonTappedWithEmptyFields() {
        
        let expectation = XCTestExpectation(description: "Alert should be shown")
        viewController.loginAlertCallback = { message in
            XCTAssertEqual(message, "Please enter both username and password.")
            expectation.fulfill()
        }
        
        viewController.loginButtonTapped(UIButton())
        
        wait(for: [expectation], timeout: 1.0)
    }
}
