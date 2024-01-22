//
//  HomeCollectionViewCellTests.swift
//  MyTVTests
//
//  Created by Rahul Anand on 22/01/24.
//

import XCTest
@testable import MyTV

final class HomeCollectionViewCellTests: XCTestCase {

    var cell: HomeCollectionViewCell!

    override func setUpWithError() throws {
        try super.setUpWithError()
        // Create an instance of HomeCollectionViewCell from the storyboard or programmatically
        // Ensure that the cell has been loaded properly, including its outlets
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let collectionView = viewController.homeCollectionView
        let indexPath = IndexPath(item: 0, section: 0)
        cell = collectionView?.dataSource?.collectionView(collectionView!, cellForItemAt: indexPath) as? HomeCollectionViewCell
    }
    
    override func tearDownWithError() throws {
        cell = nil
        try super.tearDownWithError()
    }

    func testSetThumbnailAndTitle() {
        // Given
        let thumbnail: String? = "https://example.com/image.jpg"
        let title: String? = "Test Title"

        // When
        cell.setThumbnailAndTitle(thumbnail: thumbnail, title: title)

        // Then
        // Use XCTestExpectation to wait for the asynchronous task to complete
        let expectation = XCTestExpectation(description: "Image download completion")
        
        // Assuming the download takes less than 5 seconds. You may adjust the timeout based on your needs.
        let result = XCTWaiter.wait(for: [expectation], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            // The asynchronous task didn't complete within the timeout
            XCTFail("Timed out waiting for image download.")
        }

        // Add additional assertions based on your requirements
        XCTAssertNotNil(cell.imageView.image, "Image should not be nil")
        XCTAssertEqual(cell.titleLabel.text, title, "Title should match the expected value")
    }
}

