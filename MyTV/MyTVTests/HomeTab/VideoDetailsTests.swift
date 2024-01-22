//
//  VideoDetailsTests.swift
//  MyTVTests
//
//  Created by Rahul Anand on 22/01/24.
//

import XCTest
@testable import MyTV

final class VideoDetailsTests: XCTestCase {
    
    func testVideoDetailsDecoding() throws {
        
        let json = """
            {
                "description": "Test description",
                "id": "123",
                "thumb": "https://example.com/thumb.jpg",
                "title": "Test Title",
                "url": "https://example.com/video.mp4"
            }
            """.data(using: .utf8)!
        
        let videoDetails = try JSONDecoder().decode(VideoDetails.self, from: json)
        
        XCTAssertEqual(videoDetails.description, "Test description")
        XCTAssertEqual(videoDetails.id, "123")
        XCTAssertEqual(videoDetails.thumb, "https://example.com/thumb.jpg")
        XCTAssertEqual(videoDetails.title, "Test Title")
        XCTAssertEqual(videoDetails.url, "https://example.com/video.mp4")
    }
    
    func testVideoDetailsDecodingWithMissingFields() throws {
        
        let json = """
            {
                "id": "123",
                "title": "Test Title"
            }
            """.data(using: .utf8)!
        
        let videoDetails = try JSONDecoder().decode(VideoDetails.self, from: json)
        
        XCTAssertNil(videoDetails.description)
        XCTAssertEqual(videoDetails.id, "123")
        XCTAssertNil(videoDetails.thumb)
        XCTAssertEqual(videoDetails.title, "Test Title")
        XCTAssertNil(videoDetails.url)
    }
}
