//
//  MockApplication.swift
//  NewsTests
//
//  Created by Gavin Phung on 11/04/2021.
//

import Foundation
@testable import News

class MockApplication: ApplicationProtocol {
    var url: URL?
    
    func open(url: URL) {
        self.url = url
    }
}
