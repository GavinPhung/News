//
//  SearchResultsTests.swift
//  NewsTests
//
//  Created by Gavin Phung on 11/04/2021.
//

import XCTest
@testable import News

class SearchResultsTests: XCTestCase {

    var sut: SearchResults!
    
    func test_init() {
        sut = SearchResults(status: "200", articles: [Article()])
        
        XCTAssertEqual(sut.status, "200")
        XCTAssertEqual(sut.articles, [Article()])
    }
}
