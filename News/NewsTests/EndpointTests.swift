//
//  EndpointTests.swift
//  NewsTests
//
//  Created by Gavin Phung on 11/04/2021.
//

import XCTest
@testable import News

class EndpointTests: XCTestCase {
    func test_url() {
        XCTAssertEqual(Endpoint.topHeadlines("general").url, "https://newsapi.org/v2/top-headlines?country=gb&category=general&apiKey=2767382893234ab1b7f16cd70c0c078f")
    }
}
