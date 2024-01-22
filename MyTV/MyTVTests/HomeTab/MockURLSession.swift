//
//  MockURLSession.swift
//  MyTVTests
//
//  Created by Rahul Anand on 22/01/24.
//

import Foundation
@testable import MyTV

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(data, response, error)
        return MockURLSessionDataTask()
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() {}
}
