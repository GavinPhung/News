//
//  ArticleNetworking.swift
//  News
//
//  Created by Gavin Phung on 04/04/2021.
//

import Foundation

protocol ArticleNetworking {
    func fetch(urlString: String, completion: @escaping(Result<[Article], Error>) -> Void)
}

class ArticleNetwork: ArticleNetworking {
    private var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetch(urlString: String, completion: @escaping(Result<[Article], Error>) -> Void) {
        if let url = URL(string: urlString) {
            session.loadData(with: url) { (data, response, error) in
                if error != nil {
                    completion(.failure(CustomError.error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(CustomError.badResponse))
                    return
                }
                
                if (200...299).contains(response.statusCode) {
                    do {
                        let newsResult = try JSONDecoder().decode(SearchResults.self, from: data!)
                        if newsResult.status == "ok"  {
                            if newsResult.articles.isEmpty {
                                completion(.failure(CustomError.noResults))
                            }
                            else {
                                completion(.success(newsResult.articles))
                            }
                        }
                        else {
                            completion(.failure(CustomError.badResponse))
                        }
                    }
                    catch {
                        completion(.failure(CustomError.decodeError))
                    }
                }
                else {
                    completion(.failure(CustomError.badStatusCode(response.statusCode)))
                }
            }
        }
    }
}

