//
//  NewsResult.swift
//  News
//
//  Created by Gavin Phung on 04/04/2021.
//

import Foundation

struct Article: Codable, Equatable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

struct SearchResults: Codable {
    var status: String
    var articles: [Article]
}
