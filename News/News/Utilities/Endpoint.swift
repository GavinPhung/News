//
//  Endpoint.swift
//  News
//
//  Created by Gavin Phung on 10/04/2021.
//

import Foundation

enum Endpoint {
    case topHeadlines (String)
    
    var url: String {
        let baseUrl = "https://newsapi.org/v2/"
        switch self {
        case .topHeadlines(let category):
            return "\(baseUrl)top-headlines?country=gb&category=\(category)&apiKey=\(ApiKey.key)"
        }
    }
}

enum ApiKey {
    static let key = "2767382893234ab1b7f16cd70c0c078f"
//      "310a8a133520464199498ddde094e9fe"
}
