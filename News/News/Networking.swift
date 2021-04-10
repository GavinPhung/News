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
                        completion(.failure(CustomError.decodeError))
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

