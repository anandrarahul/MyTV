//
//  HomeCollectionViewCellTests.swift
//  MyTVTests
//
//  Created by Rahul Anand on 22/01/24.
//

import XCTest
@testable import MyTV

class MockImageLoader: ImageLoaderProtocol {
    var mockImage: UIImage?

    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        completion(mockImage)
    }
}

class HomeCollectionViewCellTests: XCTestCase {
    
    var cell: HomeCollectionViewCell!
    var bundle: Bundle!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.bundle = Bundle(for: HomeCollectionViewCell.self)
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: self.bundle)
        self.cell = (nib.instantiate(withOwner: nil, options: nil).first as! HomeCollectionViewCell)
    }
    
    override func tearDownWithError() throws {
        self.cell = nil
        try super.tearDownWithError()
    }

    func testSetThumbnailAndTitleWithThumbnail() {
            let mockImageLoader = MockImageLoader()
            cell.imageLoader = mockImageLoader
        let customImage = UIImage(named: "noImage", in: self.bundle, compatibleWith: nil)
            mockImageLoader.mockImage = customImage
            let thumbnailURL = URL(string: "https://example.com/thumb.jpg")!

            cell.setThumbnailAndTitle(thumbnail: thumbnailURL.absoluteString, title: "Test Title")

            XCTAssertEqual(cell.imageView.image, customImage)
            XCTAssertEqual(cell.titleLabel.text, "Test Title")
        }

        func testSetThumbnailAndTitleWithoutThumbnail() {
            let mockImageLoader = MockImageLoader()
            cell.imageLoader = mockImageLoader
            let customImage = UIImage(named: "noImage", in: bundle, compatibleWith: nil)
            mockImageLoader.mockImage = customImage

            cell.setThumbnailAndTitle(thumbnail: nil, title: "Test Title")

            XCTAssertEqual(cell.imageView.image, customImage)
            XCTAssertEqual(cell.titleLabel.text, "Test Title")
        }
}
