//
//  NetworkTests.swift
//  NewsTests
//
//  Created by Gavin Phung on 11/04/2021.
//

import XCTest
@testable import News

class ArticleNetworkTests: XCTestCase {
    
    var sut: ArticleNetwork!
    var articles: [Article]?
    var error: CustomError?
    
    override func setUp() {
        articles = nil
        error = nil
    }
    
    func test_fetch_invalidString() {
        let mockSession = MockURLSession()
        sut = ArticleNetwork(session: mockSession)
        
        setupNetworkRequest(urlString: "")
        
        XCTAssertNil(articles)
        XCTAssertNil(error)
    }
    
    func test_fetch_errorReturned() {
        let mockSession = MockURLSession()
        
        mockSession.error = CustomError.error
        sut = ArticleNetwork(session: mockSession)
        
        setupNetworkRequest()
        
        XCTAssertNil(articles)
        XCTAssertEqual(error, CustomError.error)
    }
    
    func test_fetch_badResponse() {
        let mockSession = MockURLSession()
        
        sut = ArticleNetwork(session: mockSession)
        
        setupNetworkRequest()
        
        XCTAssertNil(articles)
        XCTAssertEqual(error, CustomError.badResponse)
    }
    
    func test_fetch_errorResponse400() {
        let mockSession = MockURLSession()
        
        mockSession.response = HTTPURLResponse(url: URL(string: "url")!, statusCode: 400, httpVersion: "", headerFields: [:])
        sut = ArticleNetwork(session: mockSession)
        
        setupNetworkRequest()
        
        XCTAssertNil(articles)
        XCTAssertEqual(error, CustomError.badStatusCode(400))
    }
    
    func test_fetch_success() {
        let mockSession = MockURLSession()
        
        mockSession.data = """
                            {"status":"ok", "articles":[{"author":"author","title":"title"}]}
                            """.data(using: .utf8)
        
        mockSession.response = HTTPURLResponse(url: URL(string: "url")!, statusCode: 200, httpVersion: "", headerFields: [:])
        
        sut = ArticleNetwork(session: mockSession)
        
        setupNetworkRequest()
        XCTAssertEqual(articles, [Article(author: "author", title: "title")])
    }
    
    func test_fetch_invalidData() {
        let mockSession = MockURLSession()
        
        mockSession.data = """
                            {"status":"ok", "articles":[{"author":"author","title":"title"]}
                            """.data(using: .utf8)
        
        mockSession.response = HTTPURLResponse(url: URL(string: "url")!, statusCode: 200, httpVersion: "", headerFields: [:])
        
        sut = ArticleNetwork(session: mockSession)
        
        setupNetworkRequest()
        XCTAssertEqual(error, CustomError.decodeError)
    }
    
    func test_fetch_noResults() {
        let mockSession = MockURLSession()
        
        mockSession.data = """
                            {"status":"ok", "articles":[]}
                            """.data(using: .utf8)
        
        mockSession.response = HTTPURLResponse(url: URL(string: "url")!, statusCode: 200, httpVersion: "", headerFields: [:])
        
        sut = ArticleNetwork(session: mockSession)
        
        setupNetworkRequest()
        XCTAssertEqual(error, CustomError.noResults)
    }
    
    func test_fetch_notOkay() {
        let mockSession = MockURLSession()
        
        mockSession.data = """
                            {"status":"bad", "articles":[{"author":"author","title":"title"}]}
                            """.data(using: .utf8)
        
        mockSession.response = HTTPURLResponse(url: URL(string: "url")!, statusCode: 200, httpVersion: "", headerFields: [:])
        
        sut = ArticleNetwork(session: mockSession)
        
        setupNetworkRequest()
        XCTAssertEqual(error, CustomError.badResponse)
    }
}

private extension ArticleNetworkTests {
    func setupNetworkRequest(urlString: String = "url") {
        sut.fetch(urlString: urlString) { (result) in
            switch result {
            case .success(let articles):
                self.articles = articles
            case .failure(let error):
                self.error = error as? CustomError
            }
        }
    }
}
