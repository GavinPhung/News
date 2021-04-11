//
//  MockArticleImageViewModelDelegate.swift
//  NewsTests
//
//  Created by Gavin Phung on 11/04/2021.
//

import UIKit
@testable import News

class MockArticleImageViewModelDelegate: ArticleImageViewModelDelegate {
    var urlFailureCalled = false
    var image: UIImage?
    
    func update(image: UIImage) {
        self.image = image
    }
    
    func urlFailure() {
        urlFailureCalled = true
    }
}

