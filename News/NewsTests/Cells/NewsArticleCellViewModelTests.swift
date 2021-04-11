//
//  NewsArticleCellViewModelTests.swift
//  NewsTests
//
//  Created by Gavin Phung on 11/04/2021.
//

import XCTest
@testable import News

class NewsArticleCellViewModelTests: XCTestCase {

    var sut: NewsArticleCellViewModel!
    var mockImageNetwork = MockImageNetwork()
    var mockDelegate = MockImageDelegate()
    
    
    func test_init() {
        sut = NewsArticleCellViewModel(article: Article(title: "Title"), imageNetwork: mockImageNetwork)
        XCTAssertEqual(sut.title, "Title")
    }
    
    func test_init_emptyArticle() {
        sut = NewsArticleCellViewModel(article: Article(), imageNetwork: mockImageNetwork)
        XCTAssertEqual(sut.title, "No title")
    }
    
    func test_updateImage() {
        sut = NewsArticleCellViewModel(article: Article(), imageNetwork: mockImageNetwork)
        sut.delegate = mockDelegate
        
        XCTAssertNil(mockDelegate.image)
        
        sut.updateImage()
        
        XCTAssertEqual(mockDelegate.image, UIImage())
    }
}
