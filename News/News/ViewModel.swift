//
//  ViewModel.swift
//  News
//
//  Created by Gavin Phung on 04/04/2021.
//

import Foundation

protocol ViewModelDelegate: class {
    func update()
    func handle(error: Error)
    func goTo(article: Article)
    func categoryClicked()
}

enum Category: String, CaseIterable {
    case general, entertainment, sport, technology, health, science
}

class Section {
    var items: [CellViewModel]
    
    init(items: [CellViewModel]) {
        self.items = items
    }
}

class ViewModel {
    private var network: ArticleNetworking
    let title = "News"
    let alertTitle = "Something went wrong"
    let buttonTitle = "Retry"
    
    weak var delegate: ViewModelDelegate?
    private var articles = [Article]()
    var sections = [Section](repeating: Section(items: []), count: 3)
    
    private var selectedCategory: Int = 0
    private var cache = NSCache<NSString, Section>()
    
    init(network: ArticleNetworking = ArticleNetwork()) {
        self.network = network
    }
    
    func onViewDidLoad() {
        network.fetch(urlString: "\(Endpoint.topHeadlines("general").url)&apiKey=\(ApiKey.key)", completion: { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.delegate?.handle(error: error)
            case .success(let articles):
                self?.articles = articles
                self?.createSections()
                self?.delegate?.update()
            }
        })
    }
    
    func onSelected(indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if let viewModel = sections[0].items[indexPath.row] as? HeadlineArticleCellViewModel {
                delegate?.goTo(article: viewModel.article)
            }
        case 1:
            if let viewModel = sections[1].items[indexPath.row] as? SegmentedControlCellViewModel {
                updateSelected(index: indexPath.row)
                searchFor(category: viewModel.title.lowercased())
            }
        case 2:
            if let viewModel = sections[2].items[indexPath.row] as? NewsArticleCellViewModel {
                delegate?.goTo(article: viewModel.article)
            }
        default:
            return
        }
    }
    
    func onRefresh() {
        cache = NSCache<NSString, Section>()
        onViewDidLoad()
    }
    
    private func createSections() {
        sections[0] = Section(items: [HeadlineArticleCellViewModel(article: articles[0]),
                                      HeadlineArticleCellViewModel(article: articles[1]),
                                      HeadlineArticleCellViewModel(article: articles[2])])
        sections[1] = Section(items: Category.allCases.map { SegmentedControlCellViewModel(title: $0.rawValue.capitalized) })
        updateSelected(index: 0)
        articles.removeSubrange(0...2)
        cacheSections(category: "general")
    }
    
    private func cacheSections(category: String) {
        let category = category as NSString
        let section = Section(items: articles.map { NewsArticleCellViewModel(article: $0) })
        cache.setObject(section, forKey: category)
        sections[2] = Section(items: articles.map { NewsArticleCellViewModel(article: $0) })
    }
    
    private func updateSelected(index: Int) {
        guard let x = sections[1].items as? [SegmentedControlCellViewModel] else { return }
        x[selectedCategory].isSelected = false
        selectedCategory = index
        x[selectedCategory].isSelected = true
    }
    
    private func searchFor(category: String) {
        if let section = cache.object(forKey: category as NSString) {
            sections[2] = section
            self.delegate?.update()
            return
        }
        
        let urlString = "\(Endpoint.topHeadlines(category).url)&apiKey=\(ApiKey.key)"
        
        network.fetch(urlString: urlString) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.delegate?.handle(error: error)
            case .success(let articles):
                self?.articles = articles
                self?.cacheSections(category: category)
                self?.delegate?.categoryClicked()
            }
        }
    }
}
