//
//  ArticleViewModel.swift
//  News
//
//  Created by Gavin Phung on 09/04/2021.
//

import UIKit

protocol ArticleViewModelDelegate {
    func urlFailure()
}

typealias ArticleImageViewModelDelegate = ImageDelegate & ArticleViewModelDelegate

class ArticleViewModel {

    let title: String = "Article"
    let articleTitle: String
    let date: String
    let author: String
    let description: String?
    let content: String?
    
    let alertTitle = "Something went wrong"
    let alertMessage = "URL could not be opened"
    let alertButtonTitle = "Okay"
    
    let buttonTitle = "Read full article"
    
    weak var delegate: ArticleImageViewModelDelegate?
    
    private var article: Article
    private let imageNetwork: ImageNetworking
    private let application: ApplicationProtocol
    
    init(article: Article, application: ApplicationProtocol = UIApplication.shared, imageNetwork: ImageNetworking = ImageNetwork.shared) {
        self.article = article
        self.imageNetwork = imageNetwork
        self.application = application
        articleTitle = article.title ?? "No title"
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
        guard let urlString = article.url, let url = URL(string: urlString) else {
            self.delegate?.urlFailure()
            return }
        application.open(url: url)
    }
}

enum Browsers {
    case safari, chrome, firefox, opera
    
    func url(string: String) {
        
    }
}

protocol ApplicationProtocol {
    func open(url: URL)
}

extension UIApplication: ApplicationProtocol {
    func open(url: URL) {
        open(url, options: [:], completionHandler: nil)
    }
}
