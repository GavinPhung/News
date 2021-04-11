//
//  MockArticleNetwork.swift
//  NewsTests
//
//  Created by Gavin Phung on 11/04/2021.
//

import Foundation
@testable import News

class MockArticleNetwork: ArticleNetworking {
    var error: CustomError?
    var articles = [Article(title:"0"), Article(title:"1"), Article(title:"2"), Article(title:"3")]
    
    init(error: CustomError? = nil) {
        self.error = error
    }
    
    var fetchCalled = 0
    
    func fetch(urlString: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        fetchCalled += 1
        if let error = error {
            completion(.failure(error))
            return
        }
        completion(.success(articles))
    }
}
