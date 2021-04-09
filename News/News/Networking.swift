//
//  Networking.swift
//  News
//
//  Created by Gavin Phung on 04/04/2021.
//

import Foundation

protocol Networking {
    func fetch(urlString: String, completion: @escaping(Result<[Article], Error>) -> Void)
}

enum CustomError: Error {
    case badResponse
    case badStatusCode (Int)
    case noResults
    case noImage
    
    var message: String {
        switch self {
        case .badResponse:
            return "Bad response"
        case .badStatusCode(let code):
            return "Error code \(code)"
        case .noResults:
            return "No results found"
        case .noImage:
            return "No image found"
        }
    }
}

enum Category: String, CaseIterable {
    case general, entertainment, sport, technology, health, science
}

enum Endpoint {
    case everything (String, Int)
    case topHeadlines (String)
    var url: String {
        let baseUrl = "https://newsapi.org/v2/"
        switch self {
        case .topHeadlines(let category):
            return "\(baseUrl)top-headlines?country=gb&category=\(category)"
        case .everything(let query, let pageNumber):
            return "\(baseUrl)everything?q=\(query)&pageNumber=\(pageNumber)"
        }
    }
}


enum ApiKey: String {
    case key = "2767382893234ab1b7f16cd70c0c078f"
//    case key = "310a8a133520464199498ddde094e9fe"
}

class Network: Networking {
    func fetch(urlString: String, completion: @escaping(Result<[Article], Error>) -> Void) {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
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
                        completion(.failure(error))
                    }
                }
                else {
                    completion(.failure(CustomError.badStatusCode(response.statusCode)))
                }
            }
            task.resume()
        }
    }
}

