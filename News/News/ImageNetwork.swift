//
//  ImageNetwork.swift
//  News
//
//  Created by Gavin Phung on 07/04/2021.
//

import UIKit

protocol ImageNetworking {
    func fetch(urlString: NSString) -> UIImage?
}

class ImageNetwork: ImageNetworking {
    static var shared = ImageNetwork()
    
    var cache = NSCache<NSString, UIImage>()
    
    func fetch(urlString: NSString) -> UIImage? {
        if let cachedImage = cache.object(forKey: urlString) {
            return cachedImage
        }
        DispatchQueue.global().async() {
            if let url = URL(string: urlString as String),
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                    self.cache.setObject(image, forKey: urlString)
                }
        }
        return cache.object(forKey: urlString)
    }
}
