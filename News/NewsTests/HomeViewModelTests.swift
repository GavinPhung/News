//
//  HomeViewModelTests.swift
//  NewsTests
//
//  Created by Gavin Phung on 11/04/2021.
//

import XCTest
@testable import News

class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModel!
    
    func test_onViewDidLoad_failure() {
        let mockDelegate = MockViewModelDelegate()
        let mockNetwork = MockArticleNetwork(error: CustomError.badResponse)
        sut = HomeViewModel(network: mockNetwork)
        sut.delegate = mockDelegate
        
        XCTAssertNil(mockDelegate.error)
        
        sut.onViewDidLoad()
        
        XCTAssertEqual(mockDelegate.error, CustomError.badResponse)
    }
    
    func test_onViewDidLoad_success() {
        let mockDelegate = MockViewModelDelegate()
        let mockNetwork = MockArticleNetwork()
        sut = HomeViewModel(network: mockNetwork)
        sut.delegate = mockDelegate
        
        XCTAssertFalse(mockDelegate.updateCalled)
        
        sut.onViewDidLoad()
        
        XCTAssertEqual(sut.sections[0].items.count, 3)
        
        assertHeadlineCell(viewModel: sut.sections[0].items[0], article: mockNetwork.articles[0])
        assertHeadlineCell(viewModel: sut.sections[0].items[1], article: mockNetwork.articles[1])
        assertHeadlineCell(viewModel: sut.sections[0].items[2], article: mockNetwork.articles[2])
        
        assertSegmentedViewCells(section: sut.sections[1])
        
        XCTAssertEqual(sut.sections[2].items.count, 1)
        assertNewsArticleCell(viewModel: sut.sections[2].items[0], article: mockNetwork.articles[3])
        
        XCTAssertTrue(mockDelegate.updateCalled)
    }

    func test_init() {
        let mockDelegate = MockViewModelDelegate()
        let mockNetwork = MockArticleNetwork()
        sut = HomeViewModel(network: mockNetwork)
        sut.delegate = mockDelegate
        
        XCTAssertEqual(sut.title, "News")
        XCTAssertEqual(sut.alertTitle, "Something went wrong")
        XCTAssertEqual(sut.buttonTitle, "Retry")
    }
    
    func test_onRefresh() {
        let mockDelegate = MockViewModelDelegate()
        let mockNetwork = MockArticleNetwork()
        sut = HomeViewModel(network: mockNetwork)
        sut.delegate = mockDelegate
        
        XCTAssertFalse(mockDelegate.updateCalled)
        
        sut.onRefresh()
        
        XCTAssertEqual(sut.sections[0].items.count, 3)
        
        assertHeadlineCell(viewModel: sut.sections[0].items[0], article: mockNetwork.articles[0])
        assertHeadlineCell(viewModel: sut.sections[0].items[1], article: mockNetwork.articles[1])
        assertHeadlineCell(viewModel: sut.sections[0].items[2], article: mockNetwork.articles[2])
        
        assertSegmentedViewCells(section: sut.sections[1])
        
        XCTAssertEqual(sut.sections[2].items.count, 1)
        assertNewsArticleCell(viewModel: sut.sections[2].items[0], article: mockNetwork.articles[3])
        
        XCTAssertTrue(mockDelegate.updateCalled)
    }
    
    func test_onSelected_networkSuccess() {
        let mockDelegate = MockViewModelDelegate()
        let mockNetwork = MockArticleNetwork()
        sut = HomeViewModel(network: mockNetwork)
        sut.delegate = mockDelegate
        
        sut.sections[1].items = [SegmentedControlCellViewModel(title: "")]
        
        sut.onSelected(indexPath: IndexPath(row: 0, section: 1))
        XCTAssertEqual(mockNetwork.fetchCalled, 1)
        
        assertNewsArticleCell(viewModel: sut.sections[2].items[0], article: mockNetwork.articles[0])
        assertNewsArticleCell(viewModel: sut.sections[2].items[1], article: mockNetwork.articles[1])
        assertNewsArticleCell(viewModel: sut.sections[2].items[2], article: mockNetwork.articles[2])
        assertNewsArticleCell(viewModel: sut.sections[2].items[3], article: mockNetwork.articles[3])
        XCTAssertFalse(mockDelegate.updateCalled)
        XCTAssertTrue(mockDelegate.categoryClickedCalled)
    }
    
    func test_onSelected_networkFailure() {
        let mockDelegate = MockViewModelDelegate()
        let mockNetwork = MockArticleNetwork(error: CustomError.badResponse)
        sut = HomeViewModel(network: mockNetwork)
        sut.delegate = mockDelegate
        
        sut.sections[1].items = [SegmentedControlCellViewModel(title: "General"), SegmentedControlCellViewModel(title: "")]
        
        sut.onSelected(indexPath: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(mockDelegate.error, CustomError.badResponse)

    }
    
    func test_onSelected_cachedResult() {
        let mockDelegate = MockViewModelDelegate()
        let mockNetwork = MockArticleNetwork()
        sut = HomeViewModel(network: mockNetwork)
        sut.delegate = mockDelegate
        
        sut.onViewDidLoad()
        XCTAssertEqual(mockNetwork.fetchCalled, 1)
        
        sut.onSelected(indexPath: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(mockNetwork.fetchCalled, 1)
        XCTAssertTrue(mockDelegate.updateCalled)
    }
    
    func test_onSelected_uncachedResult() {
        let mockDelegate = MockViewModelDelegate()
        let mockNetwork = MockArticleNetwork()
        sut = HomeViewModel(network: mockNetwork)
        sut.delegate = mockDelegate
        
        sut.onViewDidLoad()
        XCTAssertEqual(mockNetwork.fetchCalled, 1)
        
        sut.onSelected(indexPath: IndexPath(row: 1, section: 1))
        
        XCTAssertEqual(mockNetwork.fetchCalled, 2)
        XCTAssertTrue(mockDelegate.updateCalled)
    }
    
    func test_onSelected_headline() {
        let mockDelegate = MockViewModelDelegate()
        let mockNetwork = MockArticleNetwork()
        sut = HomeViewModel(network: mockNetwork)
        sut.delegate = mockDelegate
        
        sut.sections[0].items = [HeadlineArticleCellViewModel(article: Article(title: "0"), imageNetwork: MockImageNetwork())]
       
        XCTAssertNil(mockDelegate.article)
        sut.onSelected(indexPath: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(mockDelegate.article, Article(title: "0"))
    }
    
    func test_onSelected_article() {
        let mockDelegate = MockViewModelDelegate()
        let mockNetwork = MockArticleNetwork()
        sut = HomeViewModel(network: mockNetwork)
        sut.delegate = mockDelegate
        
        sut.sections[2].items = [NewsArticleCellViewModel(article: Article(title: "0"), imageNetwork: MockImageNetwork())]
       
        XCTAssertNil(mockDelegate.article)
        sut.onSelected(indexPath: IndexPath(row: 0, section: 2))
        
        XCTAssertEqual(mockDelegate.article, Article(title: "0"))
    }
    
    func test_onSelected_outOfBounds() {
        let mockDelegate = MockViewModelDelegate()
        let mockNetwork = MockArticleNetwork()
        
        sut = HomeViewModel(network: mockNetwork)
        sut.delegate = mockDelegate
       
        sut.onSelected(indexPath: IndexPath(row: 0, section: 3))
        
        XCTAssertNil(mockDelegate.article)
        XCTAssertFalse(mockDelegate.updateCalled)
    }
}

private extension HomeViewModelTests {
    func assertHeadlineCell(viewModel: CellViewModel, article: Article) {
        let viewModel = viewModel as! HeadlineArticleCellViewModel
        XCTAssertEqual(viewModel.article, article)
    }
    
    func assertSegmentedViewCells(section: Section) {
        let titles = ["General", "Entertainment", "Sport", "Technology", "Health", "Science"]
        for i in 0..<titles.count {
            let viewModel = section.items[i] as! SegmentedControlCellViewModel
            XCTAssertEqual(viewModel.title, titles[i])
        }
    }
    
    func assertNewsArticleCell(viewModel: CellViewModel, article: Article) {
        let viewModel = viewModel as! NewsArticleCellViewModel
        XCTAssertEqual(viewModel.article, article)
    }
}

class MockViewModelDelegate: ViewModelDelegate {
    var updateCalled = false
    var error: CustomError?
    var article: Article?
    var categoryClickedCalled = false
    
    func update() {
        updateCalled = true
    }
    
    func handle(error: Error) {
        guard let error = error as? CustomError else { return }
        self.error = error
    }
    
    func goTo(article: Article) {
        self.article = article
    }
    
    func categoryClicked() {
        categoryClickedCalled = true
    }
}
