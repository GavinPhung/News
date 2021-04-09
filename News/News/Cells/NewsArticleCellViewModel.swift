//
//  NewsArticleCellViewModel.swift
//  News
//
//  Created by Gavin Phung on 04/04/2021.
//

import UIKit

class NewsArticleCellViewModel: CellViewModel {
    
    let title: String
    private let article: Article
    var cellIdentifier: String = "NewsArticleCell"
    
    var image: UIImage? {
        if let url = article.urlToImage as NSString? {
            return imageNetwork.fetch(urlString: url)
        }
        return nil
    }
    
    private let imageNetwork: ImageNetworking
    
    init(article: Article, imageNetwork: ImageNetworking = ImageNetwork.shared) {
        self.article = article
        title = article.title ?? ""
        self.imageNetwork = imageNetwork
    }
}
