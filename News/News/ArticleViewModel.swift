//
//  ArticleViewModel.swift
//  News
//
//  Created by Gavin Phung on 09/04/2021.
//

import UIKit

class ArticleViewModel {
    var image: UIImage? {
        if let url = article.urlToImage as NSString? {
            return imageNetwork.fetch(urlString: url)
        }
        return nil
    }
    
    let title: String?
    let date: String?
    let author: String?
    let description: String?
    let content: String?
    
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
}
