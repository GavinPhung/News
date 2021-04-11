//
//  HeadlineArticleCellViewModelTests.swift
//  NewsTests
//
//  Created by Gavin Phung on 11/04/2021.
//

import XCTest
@testable import News

class HeadlineArticleCellViewModelTests: XCTestCase {

    var sut: HeadlineArticleCellViewModel!
    var mockImageNetwork = MockImageNetwork()
    var mockDelegate = MockImageDelegate()
    
    func test_init() {
        sut = HeadlineArticleCellViewModel(article: Article(author: "Author", title: "Title", publishedAt: "Date"), imageNetwork: mockImageNetwork)
        XCTAssertEqual(sut.title, "Title")
        XCTAssertEqual(sut.author, "Author")
        XCTAssertEqual(sut.date, "Date")
    }
    
    func test_init_emptyArticle() {
        sut = HeadlineArticleCellViewModel(article: Article(), imageNetwork: mockImageNetwork)
        XCTAssertEqual(sut.title, "No title")
    }

    func test_updateImage() {
        sut = HeadlineArticleCellViewModel(article: Article(), imageNetwork: mockImageNetwork)
        sut.delegate = mockDelegate
        
        XCTAssertNil(mockDelegate.image)
        
        sut.updateImage()
        
        XCTAssertEqual(mockDelegate.image, UIImage())
    }
}
