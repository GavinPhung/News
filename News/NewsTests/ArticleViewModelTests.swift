//
//  ArticleViewModelTests.swift
//  NewsTests
//
//  Created by Gavin Phung on 11/04/2021.
//

import XCTest
@testable import News

class ArticleViewModelTests: XCTestCase {
    
    var sut: ArticleViewModel!
    
    func test_init() {
        let mockApplication = MockApplication()
        let imageNetwork = MockImageNetwork()
        sut = ArticleViewModel(article: Article(author: "Author", title: "Title", description: "Description", publishedAt: "Date", content: "Content"), application: mockApplication, imageNetwork: imageNetwork)
        
        XCTAssertEqual(sut.title, "Article")
        XCTAssertEqual(sut.author, "Author")
        XCTAssertEqual(sut.articleTitle, "Title")
        XCTAssertEqual(sut.content, "Content")
        XCTAssertEqual(sut.description, "Description")
        XCTAssertEqual(sut.date, "Date")
        XCTAssertEqual(sut.alertTitle, "Something went wrong")
        XCTAssertEqual(sut.alertMessage, "URL could not be opened")
        XCTAssertEqual(sut.alertButtonTitle, "Okay")
        XCTAssertEqual(sut.buttonTitle, "Read full article")
    }
    
    func test_init_emptyArticle() {
        let mockApplication = MockApplication()
        let imageNetwork = MockImageNetwork()
        sut = ArticleViewModel(article: Article(), application: mockApplication, imageNetwork: imageNetwork)
        
        XCTAssertEqual(sut.articleTitle, "No title")
        XCTAssertEqual(sut.date, "No date")
        XCTAssertEqual(sut.author, "No author")
        XCTAssertNil(sut.description)
        XCTAssertNil(sut.content)
    }
    
    func test_onButtonPressed() {
        let mockApplication = MockApplication()
        let imageNetwork = MockImageNetwork()
        let mockDelegate = MockArticleImageViewModelDelegate()
        sut = ArticleViewModel(article: Article(url:"url"), application: mockApplication, imageNetwork: imageNetwork)
        sut.delegate = mockDelegate
        
        XCTAssertNil(mockApplication.url)
        
        sut.onButtonPressed()
        
        XCTAssertEqual(mockApplication.url, URL(string: "url"))
    }
    
    func test_onUpdateImage_success() {
        let mockApplication = MockApplication()
        let imageNetwork = MockImageNetwork()
        let mockDelegate = MockArticleImageViewModelDelegate()
        sut = ArticleViewModel(article: Article(), application: mockApplication, imageNetwork: imageNetwork)
        sut.delegate = mockDelegate
        
        XCTAssertNil(mockDelegate.image)
        
        sut.updateImage()
        
        XCTAssertEqual(mockDelegate.image, UIImage())
    }
    
    func test_onUpdateImage_failure() {
        let mockApplication = MockApplication()
        let imageNetwork = MockImageNetwork()
        let mockDelegate = MockArticleImageViewModelDelegate()
        sut = ArticleViewModel(article: Article(), application: mockApplication, imageNetwork: imageNetwork)
        sut.delegate = mockDelegate
        
        XCTAssertFalse(mockDelegate.urlFailureCalled)
        
        sut.onButtonPressed()
        
        XCTAssertTrue(mockDelegate.urlFailureCalled)
    }
}
