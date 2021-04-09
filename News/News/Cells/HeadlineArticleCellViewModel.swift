//
//  HeadlineArticleCellViewModel.swift
//  News
//
//  Created by Gavin Phung on 07/04/2021.
//

import UIKit

class HeadlineArticleCellViewModel: CellViewModel {
    
    let title: String
    let article: Article
    var cellIdentifier: String = "HeadlineArticleCell"
    
    var image: UIImage? {
        if let url = article.urlToImage as NSString? {
            return imageNetwork.fetch(urlString: url)
        }
        return nil
    }
    
   // var date: String
    var author: String
    
    private let imageNetwork: ImageNetworking
    
    init(article: Article, imageNetwork: ImageNetworking = ImageNetwork.shared) {
        self.article = article
        title = article.title ?? ""
        author = article.author ?? "No author"
        self.imageNetwork = imageNetwork
    }
}
