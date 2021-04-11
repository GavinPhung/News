//
//  MockImageNetwork.swift
//  NewsTests
//
//  Created by Gavin Phung on 11/04/2021.
//

import UIKit
@testable import News

class MockImageNetwork: ImageNetworking {
    func fetch(urlString: String?, completion: @escaping (UIImage) -> Void) {
        completion(UIImage())
    }
}
