//
//  MockURLSession.swift
//  NewsTests
//
//  Created by Gavin Phung on 11/04/2021.
//

import Foundation
@testable import News

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?
    
    func loadData(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(data, response, error)
    }
}
