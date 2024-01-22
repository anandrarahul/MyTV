//
//  VideoListNetworkServiceTests.swift
//  MyTVTests
//
//  Created by Rahul Anand on 22/01/24.
//

import XCTest
import Foundation
@testable import MyTV

final class VideoListNetworkServiceTests: XCTestCase {

    func testFetchVideoListSuccess() {
        let mockData = """
[
    {
        "description": "Video 1 Description",
        "id": "1",
        "thumb": "https://example.com/thumb1.jpg",
        "title": "Video 1 Title",
        "url": "https://example.com/video1.mp4"
    },
    {
        "description": "Video 2 Description",
        "id": "2",
        "thumb": "https://example.com/thumb2.jpg",
        "title": "Video 2 Title",
        "url": "https://example.com/video2.mp4"
    }
]
""".data(using: .utf8)
        let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let mockURL = URL(string: "https://example.com")!
        let mockSession = MockURLSession()
        mockSession.data = mockData
        mockSession.response = mockResponse
        let videoListService: VideoListNetworkServiceProtocol = VideoListNetworkService(session: mockSession)
        
        let expectation = XCTestExpectation(description: "Fetch video list completion")
        
        videoListService.fetchVideoList(endpoint: mockURL) { videoList, error in
            
            XCTAssertEqual(videoList?.count, 2)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchVideoListFailure() {
        let mockError = NSError(domain: "TestError", code: 123, userInfo: nil)
        let mockURL = URL(string: "https://example.com")!
        let mockSession = MockURLSession()
        mockSession.error = mockError
        let videoListService: VideoListNetworkServiceProtocol = VideoListNetworkService(session: mockSession)
        
        let expectation = XCTestExpectation(description: "Fetch video list completion")
        
        videoListService.fetchVideoList(endpoint: mockURL) { videoList, error in
            
            XCTAssertNil(videoList)
            XCTAssertEqual(error as? VideoError, VideoError.invalidResponse)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
