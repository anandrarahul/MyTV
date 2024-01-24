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
        self.cell.imageLoader = mockImageLoader
        let customImage = UIImage(named: "noImage", in: self.bundle, compatibleWith: nil)
            mockImageLoader.mockImage = customImage
            let thumbnailURL = URL(string: "https://example.com/thumb.jpg")!

        self.cell.setThumbnailAndTitle(thumbnail: thumbnailURL.absoluteString, title: "Test Title")

        XCTAssertEqual(self.cell.imageView.image, customImage)
        XCTAssertEqual(self.cell.titleLabel.text, "Test Title")
        }

        func testSetThumbnailAndTitleWithoutThumbnail() {
            let mockImageLoader = MockImageLoader()
            self.cell.imageLoader = mockImageLoader
            let customImage = UIImage(named: "noImage", in: bundle, compatibleWith: nil)
            mockImageLoader.mockImage = customImage

            self.cell.setThumbnailAndTitle(thumbnail: nil, title: "Test Title")

            XCTAssertEqual(self.cell.imageView.image, customImage)
            XCTAssertEqual(self.cell.titleLabel.text, "Test Title")
        }
}
