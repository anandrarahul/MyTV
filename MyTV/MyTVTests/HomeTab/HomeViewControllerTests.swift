//
//  HomeViewControllerTests.swift
//  MyTVTests
//
//  Created by Rahul Anand on 23/01/24.
//

import XCTest
@testable import MyTV

class MockVideoListNetworkService: VideoListNetworkServiceProtocol {
    var mockVideoDetails: [VideoDetails]?
    var mockError: Error?

    func fetchVideoList(endpoint: URL, completion: @escaping ([VideoDetails]?, Error?) -> Void) {
        completion(mockVideoDetails, mockError)
    }
}

final class HomeViewControllerTests: XCTestCase {
    
    func testPerformNetworkCallSuccess() {
        let mockService = MockVideoListNetworkService()
        let viewController = HomeViewController(videoListService: mockService)
        let expectation = XCTestExpectation(description: "Network call completed successfully")
        let mockVideoDetails = [VideoDetails(description: "Mock Description", id: "1", thumb: "mockThumb", title: "Mock Title", url: "mockURL")]
        mockService.mockVideoDetails = mockVideoDetails
        
        viewController.performNetworkCall()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            XCTAssertEqual(viewController.videoDetailsList, mockVideoDetails)
            XCTAssertTrue(viewController.activityIndicator.isHidden)
            XCTAssertTrue(viewController.errorLabel.isHidden)
            XCTAssertTrue(viewController.refreshButton.isHidden)
            XCTAssertFalse(viewController.homeCollectionView.isHidden)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPerformNetworkCallFailure() {
        let mockService = MockVideoListNetworkService()
        let viewController = HomeViewController(videoListService: mockService)
        let expectation = XCTestExpectation(description: "Network call completed with failure")
        mockService.mockError = VideoError.invalidResponse
        
        viewController.performNetworkCall()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(viewController.videoDetailsList.count, 0)
            XCTAssertTrue(viewController.activityIndicator.isHidden)
            XCTAssertFalse(viewController.errorLabel.isHidden)
            XCTAssertFalse(viewController.refreshButton.isHidden)
            XCTAssertTrue(viewController.homeCollectionView.isHidden)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
