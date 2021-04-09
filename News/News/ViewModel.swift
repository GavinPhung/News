//
//  ViewModel.swift
//  News
//
//  Created by Gavin Phung on 04/04/2021.
//

import Foundation

protocol ViewModelDelegate {
    func update()
    func handle(error: Error)
}

class Section {
    var items: [CellViewModel]
    
    init(items: [CellViewModel]) {
        self.items = items
    }
}

class ViewModel {
    private var network: Networking
    let title = "News"
    
    var delegate: ViewModelDelegate?
    private var articles = [Article]()
    var sections = [Section]()
    
    private var selectedCategory: Int = 0
    private var cache = NSCache<NSString, Section>()
    
    init(network: Networking = Network()) {
        self.network = network
    }
    
    func onViewDidLoad() {
        network.fetch(urlString: "\(Endpoint.topHeadlines("general").url)&apiKey=\(ApiKey.key.rawValue)", completion: { (result) in
            switch result {
            case .failure(let error):
                self.delegate?.handle(error: error)
            case .success(let articles):
                self.articles = articles
                self.createSections()
                self.delegate?.update()
            }
        })
    }
    
    func onSelected(indexPath: IndexPath) {
        if let viewModel = sections[1].items[indexPath.row] as? SegmentedControlCellViewModel {
            updateSelected(index: indexPath.row)
            searchFor(text: viewModel.title.lowercased())
        }
    }
    
    private func createSections() {
        sections = [Section(items: [HeadlineArticleCellViewModel(article: articles[0]),
                                    HeadlineArticleCellViewModel(article: articles[1]),
                                    HeadlineArticleCellViewModel(article: articles[2])])]
        sections.append(Section(items: Category.allCases.map { SegmentedControlCellViewModel(title: $0.rawValue) }))
        updateSelected(index: 0)
        articles.removeSubrange(0...2)
        cacheSections(category: "general")
        sections.append(Section(items: articles.map { NewsArticleCellViewModel(article: $0) }))
    }
    
    private func cacheSections(category: String) {
        let category = category as NSString
        cache.setObject(Section(items: articles.map { NewsArticleCellViewModel(article: $0) }), forKey: category)
    }
    
    private func replaceNewsArticles() {
        sections[2] = Section(items: articles.map { NewsArticleCellViewModel(article: $0) })
    }
    
    private func updateSelected(index: Int) {
        guard let x = sections[1].items as? [SegmentedControlCellViewModel] else { return }
        x[selectedCategory].isSelected = false
        selectedCategory = index
        x[selectedCategory].isSelected = true
    }
    
    private func searchFor(text: String) {
        if let section = cache.object(forKey: text as NSString) {
            sections[2] = section
            self.delegate?.update()
            return
        }
        
        let urlString = "\(Endpoint.topHeadlines(text).url)&apiKey=\(ApiKey.key.rawValue)"
        
        network.fetch(urlString: urlString) { (result) in
            switch result {
            case .failure(let error):
                self.delegate?.handle(error: error)
            case .success(let articles):
                self.articles = articles
                self.replaceNewsArticles()
                self.cacheSections(category: text)
                self.delegate?.update()
            }
        }
    }
    
//    func loadMore() {
//        network.fetch(category: .general, pageNumber: currentPage, completion: { (result) in
//            switch result {
//            case .failure(let error):
//                //self.delegate?.handle(error: error)
//            print(error)
//            case .success(let articles):
//                self.articles.append(contentsOf: articles)
//                self.createSections()
//                self.delegate?.update()
//            }
//        })
//    }
}
