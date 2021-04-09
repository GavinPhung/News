//
//  Colors.swift
//  News
//
//  Created by Gavin Phung on 09/04/2021.
//

import UIKit

enum Colors {
    case background
    
    var color: UIColor {
        switch self {
        case .background:
            return UIColor(red: 248/255.0, green: 249/255.0, blue: 253/255.0, alpha: 1)
        }
    }
}
