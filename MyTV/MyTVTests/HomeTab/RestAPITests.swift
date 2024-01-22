//
//  RestAPITests.swift
//  MyTVTests
//
//  Created by Rahul Anand on 22/01/24.
//

import XCTest
@testable import MyTV

final class RestAPITests: XCTestCase {
    
    private func loadTestPlist() -> NSDictionary {
        let testBundle = Bundle(for: type(of: self))
        guard let filePath = testBundle.path(forResource: "FB-Info", ofType: "plist"),
              let pList = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Test plist not found")
        }
        return pList
    }

    func testGetUrlForVideos() {
        
        let restAPI = RestAPI()
        
        let url = restAPI.getUrlForVideos()
        
        XCTAssertNotNil(url)
        
        // Load the test plist
        let testPlist = loadTestPlist()
        
        // Retrieve the expected host value from the test plist
        guard let expectedHost = testPlist.object(forKey: "HOST") as? String else {
            fatalError("Expected host not found in test plist")
        }
        
        XCTAssertEqual(url?.absoluteString, expectedHost)
    }
    

}
