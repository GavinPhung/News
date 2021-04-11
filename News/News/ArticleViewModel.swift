//
//  ArticleViewModel.swift
//  News
//
//  Created by Gavin Phung on 09/04/2021.
//

import UIKit

class ArticleViewModel {

    let title: String
    let date: String
    let author: String
    let description: String?
    let content: String?
    
    let buttonTitle = "Read full article"
    
    weak var delegate: ImageDelegate?
    
    private var article: Article
    private let imageNetwork: ImageNetworking
    
    
    init(article: Article, imageNetwork: ImageNetworking = ImageNetwork.shared) {
        self.article = article
        self.imageNetwork = imageNetwork
        title = article.title ?? "No title"
        date = article.publishedAt ?? "No date"
        author = article.author ?? "No author"
        description = article.description
        content = article.content
    }
    
    func updateImage() {
        imageNetwork.fetch(urlString: article.urlToImage) { (image) in
            self.delegate?.update(image: image)
        }
    }
    
    func onButtonPressed() {
        guard let urlString = article.url, let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}

enum Browsers {
    case safari, chrome, firefox, opera
    
    func url(string: String) {
        
    }
}
