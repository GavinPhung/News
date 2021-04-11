//
//  UIApplication+Extensions.swift
//  News
//
//  Created by Gavin Phung on 11/04/2021.
//

import UIKit

protocol ApplicationProtocol {
    func open(url: URL)
}

extension UIApplication: ApplicationProtocol {
    func open(url: URL) {
        open(url, options: [:], completionHandler: nil)
    }
}
