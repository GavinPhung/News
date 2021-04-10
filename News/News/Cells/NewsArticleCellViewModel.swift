//
//  NewsArticleCellViewModel.swift
//  News
//
//  Created by Gavin Phung on 04/04/2021.
//

import UIKit

class NewsArticleCellViewModel: CellViewModel {
    
    let title: String
    let article: Article
    var cellIdentifier: String = "NewsArticleCell"
    
    weak var delegate: ImageDelegate?
    
    private let imageNetwork: ImageNetworking
    
    init(article: Article, imageNetwork: ImageNetworking = ImageNetwork.shared) {
        self.article = article
        title = article.title ?? ""
        self.imageNetwork = imageNetwork
    }
    
    func updateImage() {
        imageNetwork.fetch(urlString: article.urlToImage) { [weak self] (image) in
            self?.delegate?.update(image: image)
        }
    }
}
