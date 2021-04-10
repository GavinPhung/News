//
//  ArticleViewModel.swift
//  News
//
//  Created by Gavin Phung on 09/04/2021.
//

import UIKit

class ArticleViewModel {

    let title: String?
    let date: String?
    let author: String?
    let description: String?
    let content: String?
    
    weak var delegate: ImageDelegate?
    
    private var article: Article
    private let imageNetwork: ImageNetworking
    
    
    init(article: Article, imageNetwork: ImageNetworking = ImageNetwork.shared) {
        self.article = article
        self.imageNetwork = imageNetwork
        self.title = article.title
        self.date = article.publishedAt
        self.author = article.author
        self.description = article.description
        self.content = article.content
    }
    
    func updateImage() {
        imageNetwork.fetch(urlString: article.urlToImage) { (image) in
            self.delegate?.update(image: image)
        }
    }
}
