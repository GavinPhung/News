//
//  ImageNetwork.swift
//  News
//
//  Created by Gavin Phung on 07/04/2021.
//

import UIKit

protocol ImageNetworking {
    func fetch(urlString: String?, completion: @escaping (UIImage) -> Void) -> Void
}

class ImageNetwork: ImageNetworking {
    static var shared = ImageNetwork()
    
    private var cache = NSCache<NSString, UIImage>()
    private var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetch(urlString: String?, completion: @escaping (UIImage) -> Void) -> Void {
        guard let urlString = urlString else {
            completion(UIImage(named: "placeholderNewsImage") ?? UIImage())
            return
        }
        
        if let cachedImage = cache.object(forKey: urlString as NSString) {
             completion(cachedImage)
            return
        }
        
        if let url = URL(string: urlString) {
            session.loadData(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    self.cache.setObject(image, forKey: urlString as NSString)
                    completion(image)
                    return
                }
            }
        }
        
        completion(UIImage(named: "placeholderNewsImage") ?? UIImage())
    }
}
