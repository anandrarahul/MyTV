//
//  MockNavigationController.swift
//  MyTVTests
//
//  Created by Rahul Anand on 17/01/24.
//

import UIKit

class MockNavigationController: UINavigationController {

    var presentedViewControllerToReturn: UIViewController?
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentedViewControllerToReturn = viewControllerToPresent
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }

}
