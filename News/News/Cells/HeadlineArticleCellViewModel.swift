//
//  HeadlineArticleCellViewModel.swift
//  News
//
//  Created by Gavin Phung on 07/04/2021.
//

import UIKit

protocol ImageDelegate: class {
    func update(image: UIImage)
}

class HeadlineArticleCellViewModel: CellViewModel {
    
    var cellIdentifier: String = "HeadlineArticleCell"
    
    let title: String
    let article: Article
    let date: String
    let author: String
    
    weak var delegate: ImageDelegate?
 
    private let imageNetwork: ImageNetworking
    
    init(article: Article, imageNetwork: ImageNetworking = ImageNetwork.shared) {
        self.article = article
        title = article.title ?? "No title"
        author = article.author ?? "No author"
        date = article.publishedAt ?? "No date"
        self.imageNetwork = imageNetwork
    }
    
    func updateImage() {
        imageNetwork.fetch(urlString: article.urlToImage) { [weak self] (image) in
            self?.delegate?.update(image: image)
        }
    }
}
