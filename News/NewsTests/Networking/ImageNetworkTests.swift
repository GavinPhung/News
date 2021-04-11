//
//  ImageNetworkTests.swift
//  NewsTests
//
//  Created by Gavin Phung on 11/04/2021.
//

import XCTest
import UIKit
@testable import News

class ImageNetworkTests: XCTestCase {
    var sut: ImageNetwork!
    var image: UIImage?
    
    func test_fetch_invalidString() {
        let mockURLSession = MockURLSession()
        sut = ImageNetwork(session: mockURLSession)
        
        setupNetworkRequest(urlString: nil)
        
        XCTAssertEqual(image, UIImage(named: "placeholderNewsImage"))
    }
    
    func test_fetch_invalidURL() {
        let mockURLSession = MockURLSession()
        sut = ImageNetwork(session: mockURLSession)
        
        setupNetworkRequest(urlString: "")
        
        XCTAssertEqual(image, UIImage(named: "placeholderNewsImage"))
    }
}

private extension ImageNetworkTests {
    func setupNetworkRequest(urlString: String? = "url") {
        sut.fetch(urlString: urlString) { (image) in
            self.image = image
        }
        
        
    }
}
