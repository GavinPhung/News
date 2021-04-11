//
//  ArticleTests.swift
//  NewsTests
//
//  Created by Gavin Phung on 11/04/2021.
//

import XCTest
@testable import News

class ArticleTests: XCTestCase {

    var sut: Article!
    
    func test_init() {
        sut = Article(author: "Author", title: "Title", description: "Description", url: "URL", urlToImage: "Image url", publishedAt: "Date", content: "Content")
        
        XCTAssertEqual(sut.author, "Author")
        XCTAssertEqual(sut.title, "Title")
        XCTAssertEqual(sut.content, "Content")
        XCTAssertEqual(sut.description, "Description")
        XCTAssertEqual(sut.url, "URL")
        XCTAssertEqual(sut.urlToImage, "Image url")
        XCTAssertEqual(sut.publishedAt, "Date")
    }
    
    func test_init_emptyArticle() {
        sut = Article()
        
        XCTAssertNil(sut.title)
        XCTAssertNil(sut.author)
        XCTAssertNil(sut.content)
        XCTAssertNil(sut.description)
        XCTAssertNil(sut.url)
        XCTAssertNil(sut.urlToImage)
        XCTAssertNil(sut.publishedAt)
    }
}
