//
//  URLSession+Extensions.swift
//  Global
//
//  Created by Gavin Phung on 11/04/2021.
//

import Foundation

protocol URLSessionProtocol {
    func loadData(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: URLSessionProtocol {
    func loadData(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        dataTask(with: url) { (data, response, error) in
            completionHandler(data, response, error)
        }.resume()
    }
}
